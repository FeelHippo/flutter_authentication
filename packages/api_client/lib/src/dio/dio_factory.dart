import 'package:dio/dio.dart';

class DioFactory {
  static const Duration _defaultMaxAge = Duration(hours: 1);
  static const Duration _defaultMaxStale = Duration(days: 1);

  static const Map<String, Object> defaultCacheOptions = <String, Object>{
    // If getting data from network fails or no network available,
    // try get data from cache instead of an error.
    'DIO_CACHE_KEY_FORCE_REFRESH': true,
    'DIO_CACHE_KEY_TRY_CACHE': true,
    'DIO_CACHE_KEY_MAX_AGE': _defaultMaxAge,
    'DIO_CACHE_KEY_MAX_STALE': _defaultMaxStale,
  };

  static Dio create() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://db9f87b6da56.ngrok-free.app/',
      // wifi ip from command prompt with Git Bash -> ipconfig
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final Dio dio = Dio()..options = options;

    return dio;
  }
}
