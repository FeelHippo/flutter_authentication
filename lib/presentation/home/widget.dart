import 'package:flutter/material.dart';
import 'package:flutter_authentication/bloc/auth/auth_bloc.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(SignOutAuthEvent());
          },
        ),
      ),
    );
  }
}
