import 'package:flutter_authentication/bloc/auth/auth_bloc.dart';
import 'package:injector/injector.dart';

class BlocModule {
  static AuthBloc createAuthBloc(Injector injector) => AuthBloc(
        injector.get(),
        injector.get(),
        injector.get(),
      );
}
