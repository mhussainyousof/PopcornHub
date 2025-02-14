part of 'movie_backdrop_bloc.dart';

sealed class MovieBackdropEvent extends Equatable {
  const MovieBackdropEvent();

  @override
  List<Object> get props => [];
}


final class MovieBackdropEventChanged extends MovieBackdropEvent{
  final MovieEntity movie;
  const MovieBackdropEventChanged(this.movie);

@override
List<Object> get props => [movie];
}