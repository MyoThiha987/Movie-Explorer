import 'package:flutter_architecture/core/network/exception_handler/error_body.dart';

sealed class Resource<T> {}

class Success<T> extends Resource<T> {
  final T data;
  Success({required this.data});
}

class Error<T> extends Resource<T> {
  final ErrorBody error;
  Error({required this.error});
}
