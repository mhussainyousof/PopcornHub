import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_playingnow.dart';

part 'playing_now_event.dart';
part 'playing_now_state.dart';

class PlayingNowBloc extends Bloc<PlayingNowEvent, PlayingNowState> {
  final GetPlayingNow getPlayingNow;
  PlayingNowBloc({
    required this.getPlayingNow
  }) : super(PlayingNowInitial()) {
    on<PlayingNowEvent>((event, emit)async {
      final eitherMovies  = await getPlayingNow(NoParams());
      eitherMovies.fold((error)=>SizedBox.shrink(), (movies){
        emit(NowLoadedMovieState(movies: movies));
      });
    });
  }
}
