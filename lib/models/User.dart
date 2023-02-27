import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String imagePath;
  String name;
  String shortName;
  String jurusanAngkatan;
  String hobi;
  String mediaSosial;
  String about;
  bool isDarkMode;

  User(
      {required this.imagePath,
      required this.name,
      required this.about,
      required this.isDarkMode,
      required this.hobi,
      required this.jurusanAngkatan,
      required this.mediaSosial,
      required this.shortName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
