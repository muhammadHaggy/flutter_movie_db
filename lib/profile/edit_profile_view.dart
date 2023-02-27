import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../widgets/profile_widget.dart';
import '../widgets/text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late SharedPreferences sharedPreferences;
  User? _user;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      var userString = sharedPreferences.getString('user');
      // var userString;
      // will be null if never previously saved
      if (userString == null) {
        _user = User(
            imagePath:
                "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80",
            name: "Haggy",
            email: "hagyyuwan4@gm.com",
            about: "Speedrun 3 hari gasssss",
            isDarkMode: true);
        nameController.text = _user!.name;
        emailController.text = _user!.email;
        aboutController.text = _user!.about;
        String userString = jsonEncode(_user);
        sharedPreferences.setString('user', userString);
        setState(() {});
      } else {
        Map decodeOptions = jsonDecode(userString);
        _user = User.fromJson(decodeOptions as Map<String, dynamic>);
        nameController.text = _user!.name;
        emailController.text = _user!.email;
        aboutController.text = _user!.about;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  void saveUser(User user) async {
    _user = user;
    String userString = jsonEncode(_user);
    await sharedPreferences.setString('user', userString);
  }

  @override
  Widget build(BuildContext context) => Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0x44000000),
          ),
          body: _user == null
              ? const CircularProgressIndicator()
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ProfileWidget(
                      imagePath: _user!.imagePath,
                      isEdit: true,
                      onClicked: () async {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: nameController,
                      label: 'Full Name',
                      text: _user!.name,
                      onChanged: (name) {
                        _user!.name = name;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: emailController,
                      label: 'Email',
                      text: _user!.email,
                      onChanged: (email) {
                        _user!.email = email;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: aboutController,
                      label: 'About',
                      text: _user!.about,
                      maxLines: 5,
                      onChanged: (about) {
                        _user!.about = about;
                      },
                    ),
                    const SizedBox(height: 24),
                    Center(
                        child: ButtonWidget(
                            text: "Simpan",
                            onClicked: (() {
                              saveUser(User(
                                  imagePath: _user!.imagePath,
                                  name: nameController.text,
                                  email: emailController.text,
                                  about: aboutController.text,
                                  isDarkMode: true));
                            }))),
                  ],
                ),
        );
      });
}
