import 'package:flutter/cupertino.dart';
import 'package:flutter_authentication/bloc/auth/auth_bloc.dart';
import 'package:flutter_authentication/bloc/login/cubit.dart';
import 'package:flutter_authentication/bloc/registration/cubit.dart';
import 'package:flutter_authentication/presentation/auth/auth_widget.dart';
import 'package:flutter_authentication/presentation/dependencies/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ScopeConsumerWidget extends StatelessWidget {
  const ScopeConsumerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IOC>(
      builder: (BuildContext context, IOC ioc, Widget? _child) {
        return MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<AuthBloc>(
              create: (BuildContext context) {
                return ioc.getDependency<AuthBloc>();
              },
            ),
            BlocProvider<LoginCubit>(
              create: (BuildContext context) {
                return ioc.getDependency<LoginCubit>();
              },
            ),
            BlocProvider<RegistrationCubit>(
              create: (BuildContext context) {
                return ioc.getDependency<RegistrationCubit>();
              },
            ),
          ],
          child: AuthWidget(),
        );
      },
    );
  }
}
