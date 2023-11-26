import 'http_error.dart';
import 'package:easy_localization/easy_localization.dart';
class ConflictError extends HttpError {
  ConflictError();

  @override
  String? message = 'conflict_error'.tr();
}