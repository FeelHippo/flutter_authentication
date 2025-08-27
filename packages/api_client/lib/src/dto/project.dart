import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class ProjectListDto {
  ProjectListDto({
    required this.projects,
  });

  final List<ProjectDto> projects;

  factory ProjectListDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectListDtoToJson(this);
}

@JsonSerializable()
class ProjectDto {
  ProjectDto({
    required this.name,
  });

  final String name;

  factory ProjectDto.fromJson(Map<String, dynamic> json) =>
      _$ProjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDtoToJson(this);
}
