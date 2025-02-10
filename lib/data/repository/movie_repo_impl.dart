import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/data_source/movie_remote_datasource.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/model/movie_model.dart';

class MovieRepositoryImpl extends MovieRepository{
  final  MovieRemoteDatasource remoteDataSource;
  MovieRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async{
    try{
      final movies = await remoteDataSource.getTrending();
      return right(movies);
    } catch(e){
      print('faied to getTrending$e');
    return  left(AppError('Something went wrong'));

    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async{
  try{
      final movies = await remoteDataSource.getComingSoon();
      return right(movies);
    } catch(e){
      print('faied to getTrending$e');
    return  left(AppError('Something went wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNow()async {
    try{
      final movies = await remoteDataSource.getPlayingNow();
      return right(movies);
    } catch(e){
      print('faied to getTrending$e');
    return  left(AppError('Something went wrong'));

    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async{
    try{
      final movies = await remoteDataSource.getPopular();
      return right(movies);
    } catch(e){
      print('faied to getTrending$e');
    return  left(AppError('Something went wrong'));

    }
  }
}