import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/app.dart';
import 'package:webtoon/exceptions/async_error_logger.dart';
import 'package:webtoon/exceptions/error_logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    observers: [AsyncErrorLogger()],
  );

  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  final errorLogger = container.read(errorLoggerProvider);
  registerErrorHandler(errorLogger);

  // * Entry point of the app
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

void registerErrorHandler(ErrorLogger logger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.logError(details.exception, details.stack);
  };

  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (errorDetails, stack) {
    logger.logError(errorDetails, stack);
    return true;
  };
}
