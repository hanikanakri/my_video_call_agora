import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';

class NotFoundError extends HttpError {
  @override
  String? message = 'not_found_error'.tr();
}