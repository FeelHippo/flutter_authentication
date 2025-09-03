import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';
import 'package:flutter_authentication/presentation/common/circular_progress_bar.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter.routingConfig(routingConfig: routingConfig);

// see go_router;s "Dynamic RoutingConfig"
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
