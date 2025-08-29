import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    required this.token,
    this.isLoggedIn = false,
  });

  LoginState.isAuthenticated(this.email, this.password, this.token)
    : isLoggedIn = true;

  final String? email;
  final String? password;
  final String? token;
  final bool isLoggedIn;

  @override
  List<Object?> get props => <Object?>[email, password, token, isLoggedIn];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository)
    : super(
        LoginState(
          email: null,
          password: null,
          token: null,
        ),
      );

  final AuthenticationRepository authenticationRepository;

  void authenticate({
    required String email,
    required String password,
  }) async {
    final String token = await authenticationRepository.doLogin(
      email: email,
      password: password,
    );

    if (token.isNotEmpty) {
      emit(
        LoginState.isAuthenticated(
          email,
          password,
          token,
        ),
      );
    }
  }
}
