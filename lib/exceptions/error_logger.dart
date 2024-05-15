import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webtoon/exceptions/app_exception.dart';

part 'error_logger.g.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    debugPrint('Error: $error');
    debugPrint('StackTrace: $stackTrace');
  }

  void logAppException(AppException? exception) {
    debugPrint('AppException: ${exception?.message}');
  }
}

@riverpod
ErrorLogger errorLogger(ErrorLoggerRef ref) => ErrorLogger();
