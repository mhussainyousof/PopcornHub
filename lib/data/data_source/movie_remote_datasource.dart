import 'package:popcornhub/data/core/api_client.dart';
import 'package:popcornhub/data/model/movie_detail_model.dart';
import 'package:popcornhub/data/model/movie_model.dart';
import 'package:popcornhub/data/model/movie_result.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
  Future <MovieDetailModel> getMovieDetail(int id);
}

class MovieRemoteDatasourceImpl extends MovieRemoteDatasource {
  final ApiClient _client;

  MovieRemoteDatasourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day');
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
    

  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response = await _client.get('movie/popular');
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;

}

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final response = await _client.get('movie/upcoming');
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
  final response = await _client.get('movie/now_playing');
  final movies = MovieResultModel.fromJson(response).movies;
  return movies;
  }
  
  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    return movie;
  }


  
}