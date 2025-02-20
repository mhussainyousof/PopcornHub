import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrending(); 
  Future<Either<AppError, List<MovieEntity>>> getPopular(); 
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow(); 
  Future<Either<AppError, List<MovieEntity>>> getComingSoon(); 
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id); 
}