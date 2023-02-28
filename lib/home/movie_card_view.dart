import 'package:flutter/material.dart';
import 'package:flutter_movie_db/details/detail_view.dart';
import 'package:flutter_movie_db/utils/fetch_data.dart';

import '../models/response_model.dart';

class MovieCard extends StatefulWidget {
  final String titleStartsWith;
  MovieCard({super.key, required this.titleStartsWith});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  late Future<List<Result>> _series;

  Future<List<Result>> getSeries() async {
    return await fetchSeries(
        {'limit': '10', 'titleStartsWith': widget.titleStartsWith});
  }

  @override
  void initState() {
    super.initState();
    _series = getSeries();
  }

  @override
  void didUpdateWidget(covariant MovieCard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _series = getSeries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _series,
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return Container(
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()));
          }
          final values = asyncSnapshot.data!;
          void onTap(Result series) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailScreenWidget(
                        key: UniqueKey(), series: series)));
          }

          return SizedBox(
            height: 310,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: values.length,
                itemBuilder: (context, index) {
                  final series = values[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        onTap(series);
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
                                child: Image.network(
                                    '${series.thumbnail.path}.${series.thumbnail.extension}'),
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
                                    series.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${series.startYear}-${series.endYear}',
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
