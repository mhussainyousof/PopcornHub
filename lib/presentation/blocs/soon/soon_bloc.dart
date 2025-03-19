import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_comming_soon.dart';
part 'soon_event.dart';
part 'soon_state.dart';

class SoonBloc extends Bloc<SoonEvent, SoonState> {
  final GetCommingSoon getCommingSoon;
  SoonBloc({
    required this.getCommingSoon
  }) : super(PlayingNowInitial()) {
    on<SoonEvent>((event, emit)async {
      final eitherMovies  = await getCommingSoon(NoParams());
      eitherMovies.fold((error)=>SizedBox.shrink(), (movies){
        emit(SoonLoadedMovieState(movies: movies));
      });
    });
  }
}
