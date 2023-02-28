import 'package:flutter/material.dart';
import 'package:flutter_movie_db/constants.dart';
import 'package:flutter_movie_db/home/movie_card_view.dart';
import 'package:flutter_movie_db/profile/profile_view.dart';
import 'package:flutter_movie_db/utils/fetch_data.dart';

import 'widgets/header_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const Home(),

      // home: MovieCard(titleStartsWith: 'avenger'),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          HeaderText(text: "Top Rated"),
          MovieCard(
            key: UniqueKey(),
            titleStartsWith: 'avengers',
            getMovies: TMDBApi.fetchTopRatedMovies,
          ),
          SizedBox(
            height: 14,
          ),
          HeaderText(text: "Popular"),
          MovieCard(
            key: UniqueKey(),
            titleStartsWith: 'iron',
            getMovies: TMDBApi.fetchPopularMovies,
          ),
          HeaderText(text: "Upcoming"),
          MovieCard(
            key: UniqueKey(),
            titleStartsWith: 'thor',
            getMovies: TMDBApi.fetchUpcomingMovies,
          )
        ],
      )),
    );
  }
}
