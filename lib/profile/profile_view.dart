import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../main.dart';
import '../models/User.dart';
import '../widgets/profile_widget.dart';
import 'edit_profile_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences sharedPreferences;
  User? _user;

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
        String userString = jsonEncode(_user);
        sharedPreferences.setString('user', userString);
        setState(() {});
      } else {
        Map decodeOptions = jsonDecode(userString);
        _user = User.fromJson(decodeOptions as Map<String, dynamic>);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.black54,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  'Home',
                  style: normalText.copyWith(color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'Profile',
                  style: normalText.copyWith(color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color(0x44000000),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: _user!.imagePath,
              onClicked: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const EditProfilePage()),
                );
              },
            ),
            const SizedBox(height: 24),
            buildName(_user!),
            const SizedBox(height: 48),
            buildTextWidget("Jurusan - Angkatan", _user!.jurusanAngkatan),
            const SizedBox(height: 24),
            buildTextWidget("Hobi", _user!.hobi),
            const SizedBox(height: 24),
            buildTextWidget("Media Sosial", _user!.mediaSosial),
            const SizedBox(height: 24),
            buildTextWidget("About", _user!.about),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            user.shortName,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildTextWidget(String headerText, String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headerText,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16, height: 1.4, color: Colors.white),
            ),
          ],
        ),
      );
}
