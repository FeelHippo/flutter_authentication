import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_authentication/presentation/common/scope_consumer_widget.dart';
import 'package:flutter_authentication/presentation/common/scope_provider_widget.dart';
import 'package:flutter_authentication/presentation/dependencies/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        final IOC ioc = IOC.appScope();

        runApp(AuthenticationApp(scope: ioc));

        Bloc.observer = SimpleBlocDelegate();
      },
      (Object error, StackTrace stackTrace) => print('$error, $stackTrace'),
  );
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}

class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({ super.key, required this.scope });

  final IOC scope;

  @override
  Widget build(BuildContext context) {
    return ScopeProviderWidget(
      scope: scope,
      child: MaterialApp(
        home: ScopeConsumerWidget(),
      ),
    );
  }
}

