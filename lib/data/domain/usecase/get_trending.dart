import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class GetTrending extends Usecase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;
  GetTrending(this.repository);
  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams NoParams) async{
    return await repository.getTrending();
  }
}