part of 'movie_by_genre_bloc.dart';

sealed class MovieByGenreState extends Equatable {
  const MovieByGenreState();
  
  @override
  List<Object> get props => [];
}

final class MovieByGenreInitial extends MovieByGenreState {}

class MovieByGenreLoading extends MovieByGenreState {}

class MovieByGenreLoaded extends MovieByGenreState {
  final List<MovieEntity> movies;

  const MovieByGenreLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieByGenreError extends MovieByGenreState {
  final String message;

  const MovieByGenreError(this.message);

  @override
  List<Object> get props => [message];
}