import 'dart:convert';
import 'package:http/http.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/model/movie_model.dart';
import 'package:popcornhub/data/model/movie_result.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getTrending();
}

class MovieRemoteDatasourceImpl extends MovieRemoteDatasource {
  final Client _client;

  MovieRemoteDatasourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}trending/movie/day?api_key=${ApiConstants.apiKey}'),
      headers: {'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {      
      final responseBody = json.decode(response.body);
      final movies = MovieResultModel.fromJson(responseBody).movies ?? [];
     for (var movie in movies) {
       print("🎬 ${movie.title} (ID: ${movie.id})");
     }

      return movies;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
