import 'connection_error.dart';
import 'package:easy_localization/easy_localization.dart';

class TimeoutError extends ConnectionError {
  @override
  String? message ='TimeoutError'.tr();
}