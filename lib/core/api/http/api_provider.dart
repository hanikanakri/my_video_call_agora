import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../.,/../../core/api/errors/custom_error.dart';
import '../core_models/base_response_model.dart';
import '../core_models/base_result_model.dart';
import '../errors/bad_request_error.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';

class ApiProvider {
  static var dio = Dio();

  static initial() {
//     dio.interceptors.add(PrettyDioLogger(
//         request: kDebugMode,
//         requestHeader: kDebugMode,
//         requestBody: kDebugMode,
//         responseBody: kDebugMode,
//         responseHeader: kDebugMode,
//         error: kDebugMode,
//         compact: kDebugMode,
//         maxWidth: 90));
  }

  static Future<BaseResponseModel>
      sendObjectRequest<T extends BaseResultModel>({
    required T Function(Map<String, dynamic>) converter,
    required String method,
    required String url,
    Map<String, dynamic>? data,
    required Map<String, String> headers,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? files,
    CancelToken? cancelToken,
    bool isLongTime = false,
    bool isLaravel = false,
    bool isPdf = false,
  }) async {
    var baseOptions = BaseOptions(
      connectTimeout: isLongTime ? const Duration(seconds:60 *1000 ) : const Duration(seconds:15 * 1000 ),
    );

    Options options = Options(
      headers: headers,
      method: method,
      contentType: Headers.jsonContentType,
      sendTimeout: const Duration(seconds: 8),
    );

    if (files != null) {
      headers.remove("Content-Type");
      data ??= {};

      await Future.forEach(files.entries, (MapEntry entry) async {
        if (entry.value != null) {
          data!.addAll({
            entry.key: await MultipartFile.fromFile(entry.value,
                filename: entry.value,
                contentType: isPdf
                    ? MediaType("file", "pdf")
                    : MediaType("image", "jpeg"))
          });
        }
      });
    }
    try {
      Dio dio = Dio(baseOptions);
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
      Response response;

      response = await dio.request(url,
          queryParameters: queryParameters,
          options: options,
          //   options: buildCacheOptions(Duration(days: 7),maxStale: Duration(days: 14),options: options,forceRefresh: true),
          //   cancelToken: cancelToken,
          data: files != null ? FormData.fromMap(data!) : data);
      if (null != response.headers.value("dio_cache_header_key_data_source")) {
        // data come from cache
      } else {
        // data come from net
      }
      // Get the decoded json
      dynamic decodedJson;

      if (response.data is String) {
        if (response.data.length == 0) {
          decodedJson = {"": ""};
        } else {
          decodedJson = json.decode(response.data);
        }
      } else {
        decodedJson = response.data;
      }

      return BaseResponseModel.fromJson(
          json: decodedJson, fromJson: converter, isLaravel: isLaravel);
    }

    // Handling errors
    on DioError catch (e) {
      BaseError error = _handleDioError(e);
      dynamic json;
      debugPrint('DioErrorDioErrorDioError $error');
      if (e.response != null) {
        if (e.response!.data != null) {
          if (e.response!.data is! String) {
            json = e.response!.data;
          }
        }
      }

      return BaseResponseModel.fromJson(
          json: json, error: error, isLaravel: isLaravel);
    }

    // Couldn't reach out the server
    on SocketException {
      return BaseResponseModel.fromJson(
          error: SocketError(), isLaravel: isLaravel);
    } catch (e) {
      return BaseResponseModel.fromJson(
          error: CustomError(message: 'parse error'), isLaravel: isLaravel);
    }
  }

  static BaseError _handleDioError(DioError error) {
    debugPrint('error.type = ${(error.type)}');
    if (error.type == DioExceptionType.unknown ||
        error.type == DioExceptionType.badResponse) {
      if (error is SocketException) return SocketError();
      if (error.type == DioExceptionType.badResponse) {
        switch (error.response?.statusCode ?? 400) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();

          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioExceptionType.cancel) {
      return CancelError();
    } else {
      return UnknownError();
    }
  }
}
