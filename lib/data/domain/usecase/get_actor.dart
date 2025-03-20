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

        // Create a list of Future<Either<AppError, List<Cast>>>
        final castFutures = movies.take(20).map((movie) {
          return repository.getCastCrew(movie.id);
        }).toList();

        // Execute them all in parallel
        final castResults = await Future.wait(castFutures);

        for (final result in castResults) {
          result.fold(
            (error) {
              print('خطا در گرفتن بازیگرهای فیلم: $error');
            },
            (casts) {
              final filteredCasts = casts
                  .where((cast) => cast.posterPath.isNotEmpty)
                  .take(2);

              final topCasts = filteredCasts.map(
                (cast) => ActorEntity(
                  id: cast.id,
                  name: cast.name,
                  profilePath: cast.posterPath,
                  popularity: 0.0,
                ),
              );

              actorsList.addAll(topCasts);
            },
          );
        }

        return Right(actorsList);
      },
    );
  } catch (e) {
    print('خطای کلی: $e');
    return Left(AppError(AppErrorType.api));
  }
}
}