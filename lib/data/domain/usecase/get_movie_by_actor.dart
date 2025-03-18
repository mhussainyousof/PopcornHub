import 'package:dartz/dartz.dart';

import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetMovieByActor extends Usecase<List<MovieEntity>, MovieParams> {
 final MovieRepository movieRepository;
  GetMovieByActor({
    required this.movieRepository,
  });
  @override
  Future<Either<AppError, List<MovieEntity>>> call(MovieParams params)async {
    return await movieRepository.getMoviesByActor(params.id);
  }

}
