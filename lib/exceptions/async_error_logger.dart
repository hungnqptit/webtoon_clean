import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/exceptions/app_exception.dart';
import 'package:webtoon/exceptions/error_logger.dart';
import 'package:webtoon/utils/object_extension.dart';

class AsyncErrorLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    final errorLogger = container.read(errorLoggerProvider);

    final error = _findException(newValue);
    if (error != null) {
      if (error.error is AppException) {
        errorLogger.logAppException(error.error.safeCast<AppException>());
      } else {
        errorLogger.logError(error.error, error.stackTrace);
      }
    }
  }

  AsyncError<dynamic>? _findException(Object? value) {
    if (value is AsyncError) {
      return value;
    } else {
      return null;
    }
  }
}
