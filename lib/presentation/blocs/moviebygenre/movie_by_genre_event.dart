part of 'movie_by_genre_bloc.dart';

sealed class MovieByGenreEvent extends Equatable {
  const MovieByGenreEvent();

  @override
  List<Object> get props => [];
}

class LoadMoviesByGenreEvent extends MovieByGenreEvent {
  final MovieParams params;

  const LoadMoviesByGenreEvent(this.params);

  @override
  List<Object> get props => [params];
}
