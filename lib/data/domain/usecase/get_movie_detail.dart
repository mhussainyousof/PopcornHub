import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetMovieDetail extends Usecase<MovieDetailEntity, MovieParams> {
  final MovieRepository repository;
  GetMovieDetail(this.repository);
  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams movieParams) async{
    return await repository.getMovieDetail(movieParams.id);
  }
}
