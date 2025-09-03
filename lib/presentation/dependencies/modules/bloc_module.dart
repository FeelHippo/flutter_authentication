import 'package:apiClient/main.dart';
import 'package:flutter_authentication/bloc/auth/auth_bloc.dart';
import 'package:flutter_authentication/bloc/login/cubit.dart';
import 'package:flutter_authentication/bloc/registration/cubit.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

class BlocModule {
  static AuthBloc createAuthBloc(Injector injector) => AuthBloc(
    injector.get<AuthRepository>(),
  );

  static LoginCubit createLoginCubit(Injector injector) => LoginCubit(
    injector.get<AuthenticationRepository>(),
  );

  static RegistrationCubit createRegistrationCubit(Injector injector) =>
      RegistrationCubit(
        injector.get<AuthenticationRepository>(),
      );
}
