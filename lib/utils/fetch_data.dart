import 'dart:convert';

import 'package:flutter_movie_db/detail/detail_model.dart';
import 'package:http/http.dart' as http;

Uri constructUri(String apiEndpoint, Map<String, String> queryParameters) {
  queryParameters.addAll({'apikey': '56c960657973fd721ebf9cfd184c0275'});
  return Uri.https('gateway.marvel.com:443', apiEndpoint, queryParameters);
}

Future<List<Result>> fetchSeries(Map<String, String> queryParameters) async {
  final res =
      await http.get(constructUri('/v1/public/series', queryParameters));
  final series = seriesFromJson(res.body);
  return series.data.results;
}
