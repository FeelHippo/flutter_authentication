import 'package:apiClient/main.dart';
import 'package:dio/dio.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class NetworkModule {
  static Dio createDio(Injector injector) {
    return DioFactory.create(
      authProvider: injector.get<AuthProvider>(),
    );
  }

  static ApiClient createApiClient(Injector injector) => ApiClient(
    injector.get<Dio>(),
  );
}
