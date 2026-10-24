import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleRemoteError(exception.toString());
    }
    return Failure(failureMessage: 'UnExpected Error');
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();

    if (errorMessage.contains('401') ||
        errorMessage.contains('Unauthorized') ||
        errorMessage.contains('Unauthenticated')) {
      return Failure(failureMessage: "Unauthorized");
    }

    if (errorMessage.contains('403') || errorMessage.contains('Forbidden')) {
      return Failure(failureMessage: 'Forbidden');
    }

    if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
      return Failure(failureMessage: '404 Not Found');
    }

    if (errorMessage.contains('422') ||
        errorMessage.contains('Unprocessable Content')) {
      return Failure(failureMessage: 'Unprocessable Content');
    }

    if (errorMessage.contains('500') ||
        errorMessage.contains('Internal Server Error')) {
      return Failure(failureMessage: 'Internal Server Error');
    }

    if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Connection failed') ||
        errorMessage.contains('HandshakeException')) {
      return Failure(failureMessage: 'SocketException');
    }

    if (errorMessage.contains('Timeout') || errorMessage.contains('Deadline')) {
      return Failure(failureMessage: "Deadline");
    }

    if (errorMessage.contains('TypeError') ||
        errorMessage.contains('FormatException')) {
      return Failure(failureMessage: 'FormatException');
    }

    if (errorMessage.isNotEmpty &&
        !errorMessage.contains('Exception') &&
        !errorMessage.contains('Error')) {
      return Failure(failureMessage: 'Exception');
    }

    return Failure(failureMessage: 'Exception');
  }
}
