import 'package:apiClient/main.dart';
import 'package:storage/main.dart';

class AuthenticationRepository {
  AuthenticationRepository(
    this.authenticationProvider,
    this.authProvider,
    this.userPreferences,
  );

  final AuthenticationProvider authenticationProvider;
  final AuthProvider authProvider;
  final UserPreferences userPreferences;

  Future<String> doLogin({
    required String email,
    required String password,
  }) async {
    return authenticationProvider.doLogin(
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
    return authenticationProvider.doRegister(
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
    return authenticationProvider.fetchProjects();
  }

  Future<void> completeAuthentication({
    required String token,
    required String userUid,
  }) async {
    await userPreferences.putCurrentUserId(userUid);
    await authProvider.put(AuthModel(token: token));
  }

  Future<UserModel> getCurrentUser() async {
    return authenticationProvider.getCurrentUser();
  }
}
