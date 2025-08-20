import 'package:apiClient/main.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class DomainModule {

  static UserRepository createUserRepository(Injector injector) =>
      UserRepository(
        injector.get<LoginProvider>(),
        injector.get<UserPreferences>(),
        injector.get<AuthProvider>(),
      );

  static LoginRepository createLoginRepository(Injector injector) =>
      LoginRepository(
        injector.get<LoginProvider>(),
        injector.get<AuthProvider>(),
        injector.get<UserPreferences>(),
      );

  static AuthRepository createAuthRepository(Injector injector) =>
      AuthRepository(
        injector.get<AuthProvider>(),
        injector.get<LoginRepository>(),
        injector.get<UserRepository>(),
      );
}
