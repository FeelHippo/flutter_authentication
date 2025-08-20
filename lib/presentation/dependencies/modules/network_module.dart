import 'package:apiClient/main.dart';
import 'package:dio/dio.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static Dio createDio(Injector injector) {
    return DioFactory.create();
  }

  static ApiClient createApiClient(Injector injector) =>
      ApiClient(injector.get<Dio>());
}
