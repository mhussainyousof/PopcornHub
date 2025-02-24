import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/check_if_movie_favorite.dart';
import 'package:popcornhub/data/domain/usecase/delete_favorite_movie.dart';
import 'package:popcornhub/data/domain/usecase/get_favorite_movies.dart';
import 'package:popcornhub/data/domain/usecase/save_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfMovieFavoriteMovie checkIfMovieFavoriteMovie;

  FavoriteBloc({
    required this.saveMovie,
    required this.getFavoriteMovies,
    required this.deleteFavoriteMovie,
    required this.checkIfMovieFavoriteMovie,
  }) : super(FavoriteInitial()) {
    on<LoadFavoriteMovieEvent>((event, emit) async {
      await _fetchLoadFavoriteMovies(emit);
    });

    on<ToggleFavoriteMovieEvent>((event, emit) async {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(event.movieEntity.id));
      } else {
        await saveMovie(event.movieEntity);
      }

      final response =
          await checkIfMovieFavoriteMovie(MovieParams(event.movieEntity.id));

      response.fold(
        (l) => emit(FavoriteMoviesError()),
        (r) => emit(IsFavoriteMovie(r)),
      );
    });

    on<DeleteFavoriteMovieEvent>((event, emit) async {
      await deleteFavoriteMovie(MovieParams(event.movieId));
    });

    on<CheckIfFavoriteMovie>((event, emit) async {
      final response =
          await checkIfMovieFavoriteMovie(MovieParams(event.movieId));
      response.fold(
        (l) => emit(FavoriteMoviesError()),
        (r) => emit(IsFavoriteMovie(r)),
      );
    });
  }

  Future<void> _fetchLoadFavoriteMovies(Emitter<FavoriteState> emit) async {
    final Either<AppError, List<MovieEntity>> response =
        await getFavoriteMovies(NoParams());

    response.fold(
      (l) => emit(FavoriteMoviesError()),
      (r) => emit(FavoriteMovieLoaded(r)),
    );
  }
}
