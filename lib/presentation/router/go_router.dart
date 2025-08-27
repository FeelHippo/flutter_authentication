import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/presentation/home/widget.dart';
import 'package:flutter_authentication/presentation/login/widget.dart';
import 'package:flutter_authentication/presentation/registration/widget.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginWidget();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegistrationWidget();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeWidget();
          },
        ),
      ],
    ),
  ],
);
