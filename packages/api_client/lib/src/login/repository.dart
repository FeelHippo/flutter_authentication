import 'package:apiClient/main.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:storage/main.dart';

class LoginRepository {
  LoginRepository(
    this.loginProvider,
    this.authProvider,
    this.userPreferences,
  );

  final LoginProvider loginProvider;
  final AuthProvider authProvider;
  final UserPreferences userPreferences;

  Future<LoginModel> doLogin({required LoginRequest loginRequest}) async {
    return loginProvider.doLogin(loginRequest: loginRequest);
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
