import 'package:apiClient/main.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:storage/main.dart';

abstract class LoginProvider {
  Future<LoginModel> doLogin({required LoginRequest loginRequest});
  Future<UserModel> getCurrentUser();
}
