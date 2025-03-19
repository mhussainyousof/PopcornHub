part of 'popular_movies_bloc.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();
  
  @override
  List<Object> get props => [];
}

final class PopularMoviesInitial extends PopularMoviesState {}


final class PopMovieLoadedState extends PopularMoviesState{
  final List<MovieEntity> movies;
  PopMovieLoadedState({required this.movies});


@override
List<Object> get props => [movies];

}