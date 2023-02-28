import 'package:flutter_movie_db/home/movie_card_view.dart';
import 'package:flutter_movie_db/models/movie_model.dart';
import 'package:flutter_movie_db/models/response_model.dart';
import 'package:http/http.dart' as http;

class TMDBApi {
  static Uri constructUri(
      String apiEndpoint, Map<String, String> queryParameters) {
    queryParameters.addAll({
      'api_key': '1039cc0fb99260574d76f860ad661353',
    });
    return Uri.https('api.themoviedb.org', apiEndpoint, queryParameters);
  }

  static Future<List<Result>> fetchSeries(
      Map<String, String> queryParameters) async {
    final res =
        await http.get(constructUri('/v1/public/series', queryParameters));
    final series = seriesFromJson(res.body);
    return series.data.results;
  }

  static Future<List<Movie>> fetchPopularMovies(int page) async {
    final query = {'page': page.toString()};
    final response = await http.get(constructUri('/3/movie/popular', query));
    final responseObject = responseFromJson(response.body);
    return responseObject.results;
  }

  static Future<List<Movie>> fetchTopRatedMovies(int page) async {
    final query = {'page': page.toString()};
    final response = await http.get(constructUri('/3/movie/top_rated', query));
    final responseObject = responseFromJson(response.body);
    return responseObject.results;
  }

  static Future<List<Movie>> fetchUpcomingMovies(int page) async {
    final query = {'page': page.toString()};
    final response = await http.get(constructUri('/3/movie/upcoming', query));
    final responseObject = responseFromJson(response.body);
    return responseObject.results;
  }
}
