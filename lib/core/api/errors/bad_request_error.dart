import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';
class BadRequestError extends HttpError {
  @override
  String? message = 'bad_request_error'.tr();

  BadRequestError();

}