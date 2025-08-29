// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectListDto _$ProjectListDtoFromJson(Map<String, dynamic> json) =>
    ProjectListDto(
      projects: (json['projects'] as List<dynamic>)
          .map((e) => ProjectDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectListDtoToJson(ProjectListDto instance) =>
    <String, dynamic>{
      'projects': instance.projects.map((e) => e.toJson()).toList(),
    };

ProjectDto _$ProjectDtoFromJson(Map<String, dynamic> json) =>
    ProjectDto(name: json['name'] as String);

Map<String, dynamic> _$ProjectDtoToJson(ProjectDto instance) =>
    <String, dynamic>{'name': instance.name};
