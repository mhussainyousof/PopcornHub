import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_popular.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopular getPopular;
  PopularMoviesBloc({
    required this.getPopular
  }) : super(PopularMoviesInitial()) {
    on<PopularMoviesEvent>((event, emit)async {
      final movies = await getPopular(NoParams());
      movies.fold((e)=>SizedBox.shrink(), (movies){
        emit(PopMovieLoadedState(movies: movies));
      });
    });
  }
}
