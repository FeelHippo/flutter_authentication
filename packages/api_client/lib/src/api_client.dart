import 'package:apiClient/main.dart';
import 'package:apiClient/src/dto/authentication.dart';
import 'package:apiClient/src/dto/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @Extra({AuthenticationInterceptor.nonAuth: true})
  @POST('auth/')
  Future<AuthenticationDto> login(
    @Body() LoginRequest request,
  );

  @Extra({AuthenticationInterceptor.nonAuth: true})
  @POST('register/')
  Future<AuthenticationDto> register(
    @Body() RegisterRequest request,
  );

  @GET('users/')
  Future<UserDto> getUserById(
    @Query('id') String id,
  );
}
