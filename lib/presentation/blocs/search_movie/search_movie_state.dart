part of 'search_movie_bloc.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();
  
  @override
  List<Object> get props => [];
}

final class SearchMovieInitial extends SearchMovieState {}
final class SearchMovieLoaded extends SearchMovieState {
  final List<MovieEntity> movies;
  const SearchMovieLoaded({required this.movies});
  @override
  List<Object> get props => [movies];
}

final class SearchMovieLoading extends SearchMovieState {}
final class SearchMovieError extends SearchMovieState {

  final AppErrorType appError;
  const SearchMovieError(this.appError);


  @override
  List<Object> get props => [appError];
}