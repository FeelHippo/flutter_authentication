import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.token,
    this.isLoggedIn = false,
  });

  RegistrationState.isAuthenticated(
    this.email,
    this.password,
    this.username,
    this.firstName,
    this.lastName,
    this.token,
  ) : isLoggedIn = true;

  final String? email;
  final String? password;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? token;
  final bool isLoggedIn;

  @override
  List<Object?> get props => <Object?>[
    email,
    password,
    username,
    firstName,
    lastName,
    token,
    isLoggedIn,
  ];
}

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this.authenticationRepository)
    : super(
        RegistrationState(
          email: null,
          password: null,
          username: null,
          firstName: null,
          lastName: null,
          token: null,
        ),
      );

  final AuthenticationRepository authenticationRepository;

  void register({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    final String token = await authenticationRepository.doRegister(
      email: email,
      password: password,
      username: username,
      firstName: firstName,
      lastName: lastName,
    );

    if (token.isNotEmpty) {
      emit(
        RegistrationState.isAuthenticated(
          email,
          password,
          username,
          firstName,
          lastName,
          token,
        ),
      );
    }
  }
}
