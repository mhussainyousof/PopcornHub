import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class SaveMovie extends Usecase<void, MovieEntity> {
  final MovieRepository movieRepository; 
  SaveMovie(
     this.movieRepository,
  );
  
  @override
  Future<Either<AppError, void>> call(MovieEntity params)async {
    return await movieRepository.saveMovie(params);
  }
}
