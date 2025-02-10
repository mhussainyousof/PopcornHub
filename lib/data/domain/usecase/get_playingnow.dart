import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetPlayingNow extends Usecase<List<MovieEntity>, NoParams> {
  MovieRepository repository;
  GetPlayingNow(this.repository);
  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams noParams) async{
    return await repository.getPlayingNow();
  }
}