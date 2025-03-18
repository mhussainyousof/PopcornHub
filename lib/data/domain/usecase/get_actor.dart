import 'package:dartz/dartz.dart';

import 'package:popcornhub/data/domain/entity/actor_entity.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/repository/movie_repository.dart';
import 'package:popcornhub/data/domain/usecase/usecase.dart';
class GetActors extends Usecase<List<ActorEntity>, NoParams> {
  final MovieRepository repository;
  GetActors(this.repository);

  @override
  Future<Either<AppError, List<ActorEntity>>> call(NoParams params) async {
    try {
      final moviesEither = await repository.getTrending();
      return await moviesEither.fold(
        (error) => Left(error),
        (movies) async {
          List<ActorEntity> actorsList = [];

          for (final movie in movies.take(5)) {
            final castEither = await repository.getCastCrew(movie.id);

            castEither.fold(
              (error) {
                print('Error fetching cast for movie ${movie.id}: $error');
              },
              (casts) {
                final topCasts = casts.take(3).map((cast) => ActorEntity(
                      id: cast.creditId,
                      name: cast.name,
                      profilePath: cast.posterPath,
                      popularity: 0.0,
                    ));

                actorsList.addAll(topCasts);
              },
            );
          }

          return Right(actorsList);
        },
      );
    } catch (e) {
      print('Unexpected error: $e');
      return Left(AppError(AppErrorType.api));
    }
  }
}

