import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';

class InternalServerError extends HttpError {
  @override
  String? message = 'internal_server_error'.tr();
}