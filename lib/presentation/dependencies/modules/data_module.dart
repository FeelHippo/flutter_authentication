import 'package:apiClient/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class DataModule {
  static FlutterSecureStorage createFlutterSecureStorage(Injector injector) =>
      const FlutterSecureStorage();

  static UserPreferences createUserPreferences(Injector injector) =>
      StoreUserPreferences();

  static AuthProvider createAuthProvider(Injector injector) =>
      StoreAuthProvider(
        injector.get<FlutterSecureStorage>(),
      );

  static LoginProvider createLoginProvider(Injector injector) =>
      NetworkLoginProvider(
        apiClient: injector.get<ApiClient>(),
      );
}
