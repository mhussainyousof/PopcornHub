import 'package:popcornhub/data/core/api_client.dart';
import 'package:popcornhub/data/model/actor_model.dart';
import 'package:popcornhub/data/model/actor_result.dart';

import 'package:popcornhub/data/model/cast_crew_result_data_model.dart';
import 'package:popcornhub/data/model/movie_detail_model.dart';
import 'package:popcornhub/data/model/movie_model.dart';
import 'package:popcornhub/data/model/movie_result.dart';
import 'package:popcornhub/data/model/video_model.dart';
import 'package:popcornhub/data/model/video_result_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideos(int id);
  Future<List<MovieModel>> getSearchedMovies(String searchTerm);
  Future<List<MovieModel>> getMoviesByGenre(int genreId);
  Future<List<ActorModel>> getActors();
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

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _client.get('movie/$id/credits');
    final cast = CastCrewResultModel.fromJson(response).cast;
    return cast;
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    final response = await _client.get('movie/$id/videos');
    final videos = VideoResultModel.fromJson(response).videos;
    return videos;
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String searchTerm) async {
    final response = await _client.get('search/movie', params: {
      'query': searchTerm,
    });
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }
  
  @override
  Future<List<MovieModel>> getMoviesByGenre(int genreId) async {
    final response = await _client.get('discover/movie',
    params: {
      'with_genres' : genreId,
      'sort_by' : 'popularity.desc',
      'language': 'en-US',
      'page': 1,
    }
    );
    final movies = MovieResultModel.fromJson(response).movies;
    return movies;
  }
  
  @override
  Future<List<ActorModel>> getActors() async {
    final response = await _client.get('person/popular', params: {
      'language': 'en-US',
      'page': 1,
    });
    
    final actors = ActorResultModel.fromJson(response).actors;
    return actors;
    }
}
 