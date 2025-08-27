import 'package:flutter/material.dart';
import 'package:flutter_authentication/bloc/tracker/cubit.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    context.read<TrackerCubit>().fetchProjects();
  }

  @override
  build(BuildContext context) {
    return AppScaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<TrackerCubit, TrackerState>(
          builder: (BuildContext context, TrackerState state) {
            return Column(
              children: <Widget>[],
            );
          },
        ),
      ),
    );
  }
}
