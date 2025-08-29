import 'package:apiClient/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectModel extends Equatable {
  const ProjectModel({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => <Object?>[name];
}

class TrackerState extends Equatable {
  const TrackerState({required this.projects});

  final List<ProjectModel>? projects;

  @override
  List<Object?> get props => <Object?>[projects];
}

class TrackerCubit extends Cubit<TrackerState> {
  TrackerCubit(this.authenticationRepository)
    : super(
        TrackerState(
          projects: null,
        ),
      );

  AuthenticationRepository authenticationRepository;

  void fetchProjects() async {
    final List<ProjectDto> projects = await authenticationRepository
        .fetchProjects();

    if (projects.isNotEmpty) {
      emit(
        TrackerState(
          projects: projects
              .map((ProjectDto project) => ProjectModel(name: project.name))
              .toList(),
        ),
      );
    }
  }
}
