import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/bloc/auth/auth_bloc.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';
import 'package:flutter_authentication/presentation/common/circular_progress_bar.dart';
import 'package:flutter_authentication/presentation/routes/authenticated.dart';
import 'package:flutter_authentication/presentation/routes/non_authenticated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context),
        builder: (BuildContext context, AuthState state) {
          final AuthUiModel authStatus = state.auth;

          if (authStatus is UnauthorizedAuthUiModel) {
            return NonAuthenticatedRoute();
          } else if (authStatus is AuthorizedAuthUiModel) {
            return AuthenticatedRoute();
          }
          return AppScaffold(body: Center(child: CircularProgressBar()));
        },
    );
  }
}