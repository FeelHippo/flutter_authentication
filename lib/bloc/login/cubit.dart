import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    this.isLoggedIn = false,
  });

  LoginState.isAuthenticated(this.email, this.password) : isLoggedIn = true;

  final String? email;
  final String? password;
  final bool isLoggedIn;

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[email, password, isLoggedIn];
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepository)
    : super(
        LoginState(
          email: null,
          password: null,
        ),
      );

  final LoginRepository loginRepository;

  void authenticate({
    required String email,
    required String password,
  }) async {
    final LoginModel response = await loginRepository.doLogin(
      email: email,
      password: password,
    );

    if (response.isValid) {
      emit(
        LoginState.isAuthenticated(
          email,
          password,
        ),
      );
    }
  }
}
