import 'package:dartz/dartz.dart';

import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class DeleteFavoriteMovie extends Usecase<void, MovieParams> {
  final MovieRepository movieRepository;
  DeleteFavoriteMovie(
   this.movieRepository,
  );
  
  @override
  Future<Either<AppError, void>> call(MovieParams params)async {
  return await movieRepository.deleteFavoriteMovie(params.id);
    
  }
}
