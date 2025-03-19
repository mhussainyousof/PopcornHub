part of 'soon_bloc.dart';

sealed class SoonState extends Equatable {
  const SoonState();
  
  @override
  List<Object> get props => [];
}

final class PlayingNowInitial extends SoonState {}
final class SoonLoadedMovieState extends SoonState {
  final List<MovieEntity> movies;
  SoonLoadedMovieState({required this.movies});

  @override
  List<Object> get props => [movies];
}
