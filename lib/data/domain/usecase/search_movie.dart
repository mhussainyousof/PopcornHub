import 'package:dartz/dartz.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_search_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';

class SearchMovies extends Usecase<List<MovieEntity>, MovieSearchParams> {
  final MovieRepository repository;
  SearchMovies(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(MovieSearchParams searchParam) async{
    return await repository.getSearchedMovies(searchParam.searchTerm);
  }
}