import 'package:storage/main.dart';

class AuthRepository {
  AuthRepository(
    this.authProvider,
    this.userRepository,
  );

  final AuthProvider authProvider;
  final UserRepository userRepository;

  Stream<AuthModel> get() async* {
    yield* authProvider.get();
  }

  Future<UserModel?> authorize(String token) async {
    UserModel? user = await userRepository.getCurrentUser();
    if (user != null && user.isEmpty) {
      // store auth token on device
      await authProvider.put(AuthModel(token: token));
      user = await userRepository.getCurrentUser();
    }
    return user;
  }
}
