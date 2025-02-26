import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetFavoriteMovies extends Usecase<List<MovieEntity>, NoParams> {
  final MovieRepository movieRepository;
  GetFavoriteMovies(
     this.movieRepository,
  );
  
  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams params) async{
    return await movieRepository.getFavoriteMovies();
  }
}
