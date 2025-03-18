import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/cast_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetActorsByMovie extends Usecase<List<CastEntity>, MovieParams> {
  final MovieRepository repository;

  GetActorsByMovie(this.repository);

  @override
  Future<Either<AppError, List<CastEntity>>> call(MovieParams params) async {
    return await repository.getCastCrew(params.id);
  }
}
