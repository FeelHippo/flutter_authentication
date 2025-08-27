import 'package:apiClient/main.dart';
import 'package:apiClient/src/dto/authentication.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:apiClient/src/requests/register.dart';
import 'package:storage/main.dart';

import '../dto/project.dart';

class NetworkLoginProvider extends LoginProvider {
  NetworkLoginProvider({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<String> doLogin({required LoginRequest loginRequest}) async {
    final AuthenticationDto response = await apiClient.login(loginRequest);
    return response.token;
  }

  @override
  Future<String> doRegister({
    required RegisterRequest registerRequest,
  }) async {
    final AuthenticationDto response = await apiClient.register(
      registerRequest,
    );
    return response.token;
  }

  @override
  Future<List<ProjectDto>> fetchProjects() async {
    final ProjectListDto response = await apiClient.fetchProjects();
    return response.projects;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // TODO(Filippo): TBD
    return UserModel('', '');
  }
}
