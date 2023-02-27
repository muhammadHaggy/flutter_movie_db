class User {
  String imagePath;
  String name;
  String email;
  String about;
  bool isDarkMode;

  User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        imagePath: parsedJson['imagePath'] ?? "",
        name: parsedJson['name'] ?? "",
        email: parsedJson['email'] ?? "",
        about: parsedJson['about'] ?? "",
        isDarkMode: parsedJson['isDarkMode'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "imagePath": this.imagePath,
      "name": this.name,
      "email": this.email,
      "about": this.about,
      "isDarkMode": this.isDarkMode
    };
  }
}
