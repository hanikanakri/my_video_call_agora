import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';
class ForbiddenError extends HttpError {

  @override
  String? message = 'forbidden_error'.tr();
}