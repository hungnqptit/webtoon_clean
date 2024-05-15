import 'package:dio/dio.dart';
import 'package:webtoon/constants/configs.dart';

class BaseDio {
  BaseDio._();

  static BaseDio? _instance;

  static BaseDio getInstance() {
    return _instance ??= BaseDio._();
  }

  final BaseOptions options = BaseOptions(
      baseUrl: AppConfigs.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Accept": "application/json",
        "Accept-Encoding": "gzip, deflate, br, zstd",
        'Access-Control-Allow-Origin': '*',
      });

  Dio getDio() {
    final dio = Dio(options)
      ..interceptors.addAll(
        [
          LogInterceptor(responseBody: false),
        ],
      );
    return dio;
  }
}
