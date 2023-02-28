import 'package:flutter/material.dart';
import 'package:flutter_movie_db/details/detail_view.dart';
import 'package:flutter_movie_db/models/movie_model.dart';
import 'package:flutter_movie_db/utils/create_image_url.dart';
import 'package:flutter_movie_db/utils/fetch_data.dart';

import '../models/response_model.dart';

class MovieCard extends StatefulWidget {
  final String titleStartsWith;
  final Future<List<Movie>> Function(int) getMovies;
  MovieCard(
      {super.key, required this.titleStartsWith, required this.getMovies});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  late Future<List<Movie>> _movies;

  // Future<List<Movie>> getMovies() async {
  //   return await TMDBApi.fetchPopularMovies(1);
  // }

  @override
  void initState() {
    super.initState();
    _movies = widget.getMovies(1);
  }

  @override
  void didUpdateWidget(covariant MovieCard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _movies = widget.getMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _movies,
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return Container(
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()));
          }
          final values = asyncSnapshot.data!;
          void onTap(Movie series) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailScreenWidget(
                        key: UniqueKey(), movie: series)));
          }

          return SizedBox(
            height: 310,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: values.length,
                itemBuilder: (context, index) {
                  final movies = values[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        onTap(movies);
                      },
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 280),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade900,
                                boxShadow: kElevationToShadow[8],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(createImageUrl(
                                    imageLink: movies.posterPath)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    movies.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '(${movies.releaseDate.year})',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
