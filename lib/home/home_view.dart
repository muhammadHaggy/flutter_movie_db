import 'package:flutter/material.dart';
import 'package:flutter_movie_db/details/detail_view.dart';
import 'package:flutter_movie_db/utils/fetch_data.dart';
import 'package:http/http.dart';

import '../models/detail_model.dart';

class MovieCard extends StatelessWidget {
  final String titleStartsWith;
  const MovieCard({super.key, required this.titleStartsWith});

  Future<List<Result>> getSeries() async {
    return await fetchSeries(
        {'limit': '10', 'titleStartsWith': titleStartsWith});
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: getSeries(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Container();
    //       }
    //       final values = snapshot.data!;

    //       return ElevatedButton(onPressed: testt, child: Text('test'));
    //     });
    return FutureBuilder(
        future: getSeries(),
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return Container();
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
                physics: BouncingScrollPhysics(),
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
                                child: Image.network(series.thumbnail.path +
                                    '.' +
                                    series.thumbnail.extension),
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    series.startYear.toString() +
                                        '-' +
                                        series.endYear.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
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

// class HorizontalMovieCard extends StatelessWidget {
//   final String poster;
//   final String name;
//   final String backdrop;
//   final String date;
//   final double rate;
//   final String id;
//   final Color color;
//   final bool isMovie;
//   const HorizontalMovieCard({
//     Key? key,
//     required this.poster,
//     required this.name,
//     required this.backdrop,
//     required this.date,
//     required this.id,
//     required this.color,
//     required this.isMovie,
//     required this.rate,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: InkWell(
//         onTap: () {
//           if (isMovie) {
//             pushNewScreen(
//               context,
//               MovieDetailsScreen(
//                 id: id,
//                 backdrop: backdrop,
//               ),
//             );
//           } else {
//             pushNewScreen(
//               context,
//               TvShowDetailScreen(
//                 backdrop: backdrop,
//                 id: id,
//               ),
//             );
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Flexible(
//               flex: 1,
//               child: Container(
//                 decoration: BoxDecoration(boxShadow: kElevationToShadow[8]),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: AspectRatio(
//                     aspectRatio: 9 / 14,
//                     child: CachedNetworkImage(
//                       imageUrl: poster,
//                       fit: BoxFit.cover,
//                       progressIndicatorBuilder:
//                           (context, url, downloadProgress) => Container(
//                         color: Colors.grey.shade900,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: normalText.copyWith(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: color,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       date,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: normalText.copyWith(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w900,
//                         color: color.withOpacity(.8),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         IconTheme(
//                           data: const IconThemeData(
//                             color: Colors.cyanAccent,
//                             size: 20,
//                           ),
//                           child: StarDisplay(
//                             value: ((rate * 5) / 10).round(),
//                           ),
//                         ),
//                         Text(
//                           "  " + rate.toString() + "/10",
//                           style: normalText.copyWith(
//                             color: Colors.amber,
//                             letterSpacing: 1.2,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
