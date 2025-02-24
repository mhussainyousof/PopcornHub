import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class CheckIfMovieFavoriteMovie extends Usecase<bool, MovieParams> {
 final MovieRepository movieRepository;
  CheckIfMovieFavoriteMovie(
     this.movieRepository,
  );
  @override
  Future<Either<AppError, bool>> call(MovieParams params) {
   return movieRepository.checkIfMovieFavorite(params.id);
  }
}
