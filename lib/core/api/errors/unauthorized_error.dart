import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';

class UnauthorizedError extends HttpError {
  @override
  String? message = 'unauthorized_error'.tr();
}