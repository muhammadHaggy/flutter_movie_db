// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      about: json['about'] as String,
      isDarkMode: json['isDarkMode'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'imagePath': instance.imagePath,
      'name': instance.name,
      'email': instance.email,
      'about': instance.about,
      'isDarkMode': instance.isDarkMode,
    };
