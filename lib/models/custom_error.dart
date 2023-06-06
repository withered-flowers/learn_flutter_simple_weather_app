// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errorMsg;

  const CustomError({
    this.errorMsg = '',
  });

  @override
  String toString() => 'CustomError(errorMsg: $errorMsg)';

  @override
  List<Object> get props => [errorMsg];
}
