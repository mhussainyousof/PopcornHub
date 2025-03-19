part of 'playing_now_bloc.dart';

sealed class PlayingNowState extends Equatable {
  const PlayingNowState();
  
  @override
  List<Object> get props => [];
}

final class PlayingNowInitial extends PlayingNowState {}
final class NowLoadedMovieState extends PlayingNowState {
  final List<MovieEntity> movies;
  NowLoadedMovieState({required this.movies});

  @override
  List<Object> get props => [movies];
}
