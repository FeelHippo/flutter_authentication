import 'package:dio/dio.dart';
import 'package:storage/main.dart';

class AuthenticationInterceptor extends Interceptor {
  static const String nonAuth = 'no_auth';
  static const Map<String, Object> isNonAuthenticated = <String, Object>{
    nonAuth: true,
  };

  AuthenticationInterceptor({
    required this.authProvider,
  });

  final AuthProvider authProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra.containsKey(nonAuth) && options.extra[nonAuth] == true) {
      handler.next(options);
      return;
    }

    final AuthModel authModel = await authProvider.get().last;

    if (authModel.isEmpty) {
      handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 401,
        ),
      );
    }

    options.headers['Authorization'] = 'Bearer ${authModel.token}';
    options.contentType = 'application/json';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // refresh token
    } else if (err.response?.statusCode == 403) {
      // redirect
    }
    super.onError(err, handler);
  }
}
