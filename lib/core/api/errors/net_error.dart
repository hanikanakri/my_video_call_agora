
import './connection_error.dart';
import 'package:easy_localization/easy_localization.dart';
class NetError extends ConnectionError {
  @override
  String? message = 'net_error'.tr();

}