import 'package:apiClient/src/dto/authentication.dart';
import 'package:apiClient/src/dto/project.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:apiClient/src/requests/register.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST('auth/')
  Future<AuthenticationDto> login(
    @Body() LoginRequest request,
  );

  @POST('register/')
  Future<AuthenticationDto> register(
    @Body() RegisterRequest request,
  );

  @GET('projects/')
  Future<ProjectListDto> fetchProjects();
}
