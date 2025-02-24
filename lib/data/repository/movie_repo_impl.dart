import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/data_source/movie_local_data_source.dart';
import 'package:popcornhub/data/data_source/movie_remote_datasource.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/model/cast_crew_result_data_model.dart';
import 'package:popcornhub/data/model/movie_detail_model.dart';
import 'package:popcornhub/data/model/movie_model.dart';
import 'package:popcornhub/data/model/video_model.dart';
import 'package:popcornhub/data/table/movie_table.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDatasource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  MovieRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource);
  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return right(movies);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    } on Exception {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getComingSoon() async {
    try {
      final movies = await remoteDataSource.getComingSoon();
      return right(movies);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    } on Exception {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPlayingNow() async {
    try {
      final movies = await remoteDataSource.getPlayingNow();
      return right(movies);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    } on Exception {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPopular() async {
    try {
      final movies = await remoteDataSource.getPopular();
      return right(movies);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    } on Exception {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return right(movie);
    } on SocketException {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getCastCrew(int id) async {
    try {
      final castCrew = await remoteDataSource.getCastCrew(id);
      return right(castCrew);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    } on Exception {
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<VideoModel>>> getVideos(int id) async{
    try{
      final videos = await remoteDataSource.getVideos(id);
      return right(videos);
    }on SocketException{
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }
  
  @override
  Future<Either<AppError, List<MovieModel>>> getSearchedMovies(String searchTerm) async{
    try{
      final movies = await remoteDataSource.getSearchedMovies(searchTerm);
      return right(movies);
    }on SocketException{
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }   

  }

  @override
  Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId)async {
     try{
      final response = await localDataSource.checkIfMovieFavorite (movieId);
      return right(response);
    } on Exception 
    {
     return left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId)async {
    try{
      final response = await localDataSource.deleteMovie(movieId);
      return right(response);
    } on Exception 
    {
     return left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies()async {
    try{
      final response = await localDataSource.getMovies();
      return right(response);
    } on Exception 
    {
     return left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity)async {
    try{
      final response = await localDataSource.saveMovie(MovieTable.formMovieEntity(movieEntity));
      return right(response);
    } on Exception 
    {
     return left(AppError(AppErrorType.database));
    }
  }
}
