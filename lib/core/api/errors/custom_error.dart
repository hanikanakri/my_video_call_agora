import 'base_error.dart';

class CustomError extends BaseError {

  @override
  final String message;

  CustomError({this.message = ""});

  List<Object> get props => [];
}