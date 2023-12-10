import 'package:easy_localization/easy_localization.dart';

import 'base_error.dart';

class ConnectionError extends BaseError {
  @override
  String? message = 'connection_error'.tr();

  List<Object> get props => [];
}