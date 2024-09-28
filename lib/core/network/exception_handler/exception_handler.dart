import 'package:dio/dio.dart';

import 'error_body.dart';

class ExceptionHandler implements Exception {
  late ErrorBody errorBody;

  ExceptionHandler.handle(dynamic error) {
    if (error is DioException) {
      errorBody = _handleError(error);
    } else {
      errorBody = ErrorType.DEFAULT.getError();
    }
  }
}

ErrorBody _handleError(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorType.CONNECT_TIMEOUT.getError();
    case DioExceptionType.sendTimeout:
      return ErrorType.SEND_TIMEOUT.getError();
    case DioExceptionType.receiveTimeout:
      return ErrorType.RECIEVE_TIMEOUT.getError();
    case DioExceptionType.badResponse:
      if (exception.response != null &&
          exception.response?.statusCode != null &&
          exception.response?.statusMessage != null) {
        return ErrorBody(
            code: exception.response?.statusCode ?? 0,
            message: exception.response?.data["message"] ?? "");
      } else {
        return ErrorType.DEFAULT.getError();
      }
    case DioExceptionType.cancel:
      return ErrorType.CANCEL.getError();
    default:
      return ErrorType.DEFAULT.getError();
  }
}

enum ErrorType {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension ErrorTypeExtension on ErrorType {
  ErrorBody getError() {
    switch (this) {
      case ErrorType.SUCCESS:
        return ErrorBody(
            code: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS);
      case ErrorType.NO_CONTENT:
        return ErrorBody(
            code: ResponseCode.NO_CONTENT, message: ResponseMessage.NO_CONTENT);
      case ErrorType.BAD_REQUEST:
        return ErrorBody(
            code: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case ErrorType.UNAUTORISED:
        return ErrorBody(
            code: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED);
      case ErrorType.FORBIDDEN:
        return ErrorBody(
            code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN);
      case ErrorType.INTERNAL_SERVER_ERROR:
        return ErrorBody(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case ErrorType.NOT_FOUND:
        return ErrorBody(
            code: ResponseCode.NOT_FOUND, message: ResponseMessage.NOT_FOUND);
      case ErrorType.CONNECT_TIMEOUT:
        return ErrorBody(
            code: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);
      case ErrorType.CANCEL:
        return ErrorBody(
            code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case ErrorType.RECIEVE_TIMEOUT:
        return ErrorBody(
            code: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);
      case ErrorType.SEND_TIMEOUT:
        return ErrorBody(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);
      case ErrorType.CACHE_ERROR:
        return ErrorBody(
            code: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case ErrorType.NO_INTERNET_CONNECTION:
        return ErrorBody(
            code: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponseMessage.NO_INTERNET_CONNECTION);
      case ErrorType.DEFAULT:
        return ErrorBody(
            code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "Success";
  static const String NO_CONTENT = "No Content";
  static const String BAD_REQUEST = "Bad Request Error";
  static const String UNAUTORISED = "Unauthorized Error";
  static const String FORBIDDEN = "Forbidden Error";
  static const String INTERNAL_SERVER_ERROR = "Internal Server Error";
  static const String NOT_FOUND = "Not Found Error";
  static const String CONNECT_TIMEOUT = "Timeout Error";
  static const String CANCEL = "Cancel Error";
  static const String RECIEVE_TIMEOUT = "Receive Timeout Error";
  static const String SEND_TIMEOUT = "Send Timeout Error";
  static const String CACHE_ERROR = "Cache Error";
  static const String NO_INTERNET_CONNECTION = "No Internet Connection";
  static const String DEFAULT = "Default Error";
}
