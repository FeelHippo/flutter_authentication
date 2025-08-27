import 'package:flutter/material.dart';
import 'package:flutter_authentication/bloc/auth/auth_bloc.dart';
import 'package:flutter_authentication/presentation/router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: (BuildContext context, AuthState state) {
        final AuthUiModel authStatus = state.auth;

        // TODO: separate routing depending on authentication
        return MaterialApp.router(routerConfig: router);
      },
    );
  }
}
