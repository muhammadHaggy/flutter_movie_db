import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/widgets/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../widgets/text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late SharedPreferences sharedPreferences;
  User? _user;
  final imagePathController = TextEditingController();
  final nameController = TextEditingController();
  final shortNameController = TextEditingController();
  final mediaSosialController = TextEditingController();
  final aboutController = TextEditingController();
  final hobiController = TextEditingController();
  final jurusanAngkatanController = TextEditingController();

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
          about: "Speedrun 3 hari gasssss",
          isDarkMode: true,
          hobi: 'makan',
          jurusanAngkatan: 'ilkom 21',
          mediaSosial: 'muhammadhaggy (line)',
          shortName: 'Hagi',
        );
        imagePathController.text = _user!.imagePath;
        nameController.text = _user!.name;
        aboutController.text = _user!.about;
        shortNameController.text = _user!.shortName;
        jurusanAngkatanController.text = _user!.jurusanAngkatan;
        hobiController.text = _user!.hobi;
        mediaSosialController.text = _user!.hobi;
        String userString = jsonEncode(_user);
        sharedPreferences.setString('user', userString);
        setState(() {});
      } else {
        Map decodeOptions = jsonDecode(userString);
        _user = User.fromJson(decodeOptions as Map<String, dynamic>);
        imagePathController.text = _user!.imagePath;
        nameController.text = _user!.name;
        aboutController.text = _user!.about;
        shortNameController.text = _user!.shortName;
        jurusanAngkatanController.text = _user!.jurusanAngkatan;
        hobiController.text = _user!.hobi;
        mediaSosialController.text = _user!.hobi;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    imagePathController.dispose();
    aboutController.dispose();
    shortNameController.dispose();
    jurusanAngkatanController.dispose();
    hobiController.dispose();
    mediaSosialController.dispose();
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
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: const Color(0x44000000),
          ),
          body: _user == null
              ? const CircularProgressIndicator()
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: imagePathController,
                      label: 'Profile Image Url',
                      text: _user!.imagePath,
                      onChanged: (imagePath) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: nameController,
                      label: 'Full Name',
                      text: _user!.name,
                      onChanged: (name) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: shortNameController,
                      label: 'Nama Panggilan',
                      text: _user!.shortName,
                      onChanged: (name) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: jurusanAngkatanController,
                      label: 'Jurusan-angkatan',
                      text: _user!.jurusanAngkatan,
                      onChanged: (name) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: hobiController,
                      label: 'Hobi',
                      text: _user!.hobi,
                      onChanged: (hobi) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: mediaSosialController,
                      label: 'Media Sosial',
                      text: _user!.mediaSosial,
                      onChanged: (mediaSosial) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: aboutController,
                      label: 'About',
                      text: _user!.about,
                      maxLines: 5,
                      onChanged: (about) {},
                    ),
                    const SizedBox(height: 24),
                    Center(
                        child: ButtonWidget(
                            text: "Simpan",
                            onClicked: (() {
                              saveUser(User(
                                imagePath: imagePathController.text,
                                name: nameController.text,
                                about: aboutController.text,
                                isDarkMode: true,
                                hobi: hobiController.text,
                                jurusanAngkatan: jurusanAngkatanController.text,
                                mediaSosial: mediaSosialController.text,
                                shortName: shortNameController.text,
                              ));
                            }))),
                  ],
                ),
        );
      });
}
