import 'package:apiClient/src/dto/project.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:storage/main.dart';

import '../requests/register.dart';

abstract class LoginProvider {
  Future<String> doLogin({required LoginRequest loginRequest});

  Future<String> doRegister({
    required RegisterRequest registerRequest,
  });

  Future<List<ProjectDto>> fetchProjects();

  Future<UserModel> getCurrentUser();
}
