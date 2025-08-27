import 'package:apiClient/main.dart';
import 'package:apiClient/src/dto/project.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:storage/main.dart';

import '../requests/register.dart';

class LoginRepository {
  LoginRepository(
    this.loginProvider,
    this.authProvider,
    this.userPreferences,
  );

  final LoginProvider loginProvider;
  final AuthProvider authProvider;
  final UserPreferences userPreferences;

  Future<String> doLogin({
    required String email,
    required String password,
  }) async {
    return loginProvider.doLogin(
      loginRequest: LoginRequest(
        email: email,
        password: password,
      ),
    );
  }

  Future<String> doRegister({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    return loginProvider.doRegister(
      registerRequest: RegisterRequest(
        email: email,
        password: password,
        username: username,
        firstName: firstName,
        lastName: lastName,
        isAdmin: false,
      ),
    );
  }

  Future<List<ProjectDto>> fetchProjects() async {
    return loginProvider.fetchProjects();
  }

  Future<void> completeLogin({
    required String token,
    required String userUid,
  }) async {
    await userPreferences.putCurrentUserId(userUid);
    await authProvider.put(AuthModel(token: token));
  }

  Future<UserModel> getCurrentUser() async {
    return loginProvider.getCurrentUser();
  }
}
