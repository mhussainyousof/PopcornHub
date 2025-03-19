part of 'playing_now_bloc.dart';

sealed class PlayingNowEvent extends Equatable {
  const PlayingNowEvent();

  @override
  List<Object> get props => [];
}


final class NowLoadMovieEvent extends PlayingNowEvent{}