import 'package:apiClient/main.dart';
import 'package:apiClient/src/requests/login.dart';
import 'package:storage/main.dart';

class NetworkLoginProvider extends LoginProvider {
  NetworkLoginProvider({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<LoginModel> doLogin({required LoginRequest loginRequest}) async {
    // Validate username and password
    return LoginModel(token: 'Bearer ey...', userUid: 'abc123');
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // TODO(Filippo): TBD
    return UserModel('', '');
  }
}
