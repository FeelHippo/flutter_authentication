import 'dart:io';

import 'package:storage/main.dart';
import 'package:apiClient/main.dart';

class UserRepository {
  UserRepository(
    this._loginProvider,
    this._userPreferences,
    this._authProvider,
  );
  final LoginProvider _loginProvider;
  final UserPreferences _userPreferences;
  final AuthProvider _authProvider;

  Future<bool> isThereCurrentUser() async {
    final String? userId = await _userPreferences.getCurrentUserId();
    final AuthModel authModel = await _authProvider.get().first;
    return userId != null && !authModel.isEmpty;
  }

  Future<UserModel?> getCurrentUser({bool refresh = false}) async {
    final String? userId = await _userPreferences.getCurrentUserId();
    if (userId == null) {
      await clearUserData();
      return null;
    }
    final UserModel? user = await _loginProvider.getCurrentUser();
    return user;
  }

  Future<void> logout() async {
    await clearUserData();
    return;
  }

  Future<dynamic> clearUserData() async {
    await _userPreferences.clearRegisteredDeviceToken();
    await _userPreferences.clearCurrentUserId();
    await _userPreferences.clearAllPref();
    await _userPreferences.clearAuth();
    await _authProvider.remove();
  }
}
