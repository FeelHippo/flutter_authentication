import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';
import 'package:flutter_authentication/presentation/common/circular_progress_bar.dart';
import 'package:go_router/go_router.dart';

import '../home/widget.dart';
import '../login/widget.dart';
import '../registration/widget.dart';

final GoRouter router = GoRouter.routingConfig(
  routingConfig: routingConfig,
  initialLocation: '/',
);

final ValueNotifier<RoutingConfig> routingConfig = ValueNotifier<RoutingConfig>(
  RoutingConfig(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (_, __) => AppScaffold(
          body: Center(
            child: CircularProgressBar(),
          ),
        ),
      ),
    ],
  ),
);

final RoutingConfig unauthorizedRoutingConfig = RoutingConfig(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const LoginWidget(),
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

final RoutingConfig authorizedRoutingConfig = RoutingConfig(
  redirect: (BuildContext context, GoRouterState state) {
    // this is a workaround. When coming from unauthorizedRoutingConfig.register
    // the context is not updated, and keeps '/register' as the current route
    // which is not a valid authorizedRoutingConfig route, causing an error
    if (state.matchedLocation.contains('register')) {
      return '/';
    } else {
      return null;
    }
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (_, __) => const HomeWidget(),
    ),
  ],
);
