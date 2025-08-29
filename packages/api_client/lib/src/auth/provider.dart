import 'package:apiClient/main.dart';
import 'package:storage/main.dart';

abstract class AuthenticationProvider {
  Future<String> doLogin({
    required LoginRequest loginRequest,
  });

  Future<String> doRegister({
    required RegisterRequest registerRequest,
  });

  // TODO: move to projects module
  Future<List<ProjectDto>> fetchProjects();

  Future<UserModel> getCurrentUser();
}
