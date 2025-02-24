part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteMoviesError extends FavoriteState {}

final class IsFavoriteMovie extends FavoriteState {
  final bool isMovieFavorite;
  const IsFavoriteMovie(this.isMovieFavorite);
    @override
  List<Object> get props => [isMovieFavorite];
}

final class FavoriteMovieLoaded extends FavoriteState {
  final List<MovieEntity> movies;
  const FavoriteMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}
