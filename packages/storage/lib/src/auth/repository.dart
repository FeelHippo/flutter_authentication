import 'package:storage/main.dart';
import 'package:apiClient/main.dart';

class AuthRepository {
  AuthRepository(
    this.authProvider,
    this.loginInteractor,
    this.userInteractor,
  );
  final AuthProvider authProvider;
  final LoginRepository loginInteractor;
  final UserRepository userInteractor;

  Stream<AuthModel> get() async* {
    yield* authProvider.get();
  }

  Future<UserModel?> authorize(String token) async {
    UserModel? user = await userInteractor.getCurrentUser();
    if (user != null && user.isEmpty) {
      await loginInteractor.completeLogin(token: token, userUid: user.uid);
      user = await userInteractor.getCurrentUser();
    }
    return user;
  }
}
