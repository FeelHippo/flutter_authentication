import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/presentation/login/widget.dart';
import 'package:flutter_authentication/presentation/registration/widget.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter.routingConfig(routingConfig: routingConfig);

// see go_router;s "Dynamic RoutingConfig"
final ValueNotifier<RoutingConfig> routingConfig = ValueNotifier<RoutingConfig>(
  RoutingConfig(
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
  ),
);
