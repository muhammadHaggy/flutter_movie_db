// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      about: json['about'] as String,
      isDarkMode: json['isDarkMode'] as bool,
      hobi: json['hobi'] as String,
      jurusanAngkatan: json['jurusanAngkatan'] as String,
      mediaSosial: json['mediaSosial'] as String,
      shortName: json['shortName'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'imagePath': instance.imagePath,
      'name': instance.name,
      'shortName': instance.shortName,
      'jurusanAngkatan': instance.jurusanAngkatan,
      'hobi': instance.hobi,
      'mediaSosial': instance.mediaSosial,
      'about': instance.about,
      'isDarkMode': instance.isDarkMode,
    };
