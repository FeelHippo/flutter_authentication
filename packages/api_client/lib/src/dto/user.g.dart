// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) =>
    UserDto(user: UserDataDto.fromJson(json['user'] as Map<String, dynamic>));

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'user': instance.user.toJson(),
};

UserDataDto _$UserDataDtoFromJson(Map<String, dynamic> json) => UserDataDto(
  id: json['id'] as String,
  email: json['email'] as String,
  username: json['username'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
);

Map<String, dynamic> _$UserDataDtoToJson(UserDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
