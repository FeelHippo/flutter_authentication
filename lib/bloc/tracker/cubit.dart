import 'package:apiClient/main.dart';
import 'package:apiClient/src/dto/project.dart';
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
  TrackerCubit(this.loginRepository)
    : super(
        TrackerState(
          projects: null,
        ),
      );

  final LoginRepository loginRepository;

  void fetchProjects() async {
    final List<ProjectDto> projects = await loginRepository.fetchProjects();

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
