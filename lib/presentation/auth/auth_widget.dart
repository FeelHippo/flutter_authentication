import 'package:flutter/material.dart';
import 'package:flutter_authentication/bloc/auth/auth_bloc.dart';
import 'package:flutter_authentication/presentation/home/widget.dart';
import 'package:flutter_authentication/presentation/router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../login/widget.dart';
import '../registration/widget.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context)..add(FetchAuthEvent()),
      builder: (BuildContext context, AuthState state) {
        final AuthUiModel authStatus = state.auth;

        if (authStatus is UnauthorizedAuthUiModel) {
          // see go_router's "Dynamic RoutingConfig"
          routingConfig.value = RoutingConfig(
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (_, __) => LoginWidget(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'register',
                    builder: (BuildContext context, GoRouterState state) {
                      return const RegistrationWidget();
                    },
                  ),
                ],
              ),
            ],
          );
        }
        if (authStatus is AuthorizedAuthUiModel) {
          // see go_router's "Dynamic RoutingConfig"
          routingConfig.value = RoutingConfig(
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (_, __) => HomeWidget(),
              ),
            ],
          );
        }

        return MaterialApp.router(
          routerConfig: router,
        );
      },
    );
  }
}
