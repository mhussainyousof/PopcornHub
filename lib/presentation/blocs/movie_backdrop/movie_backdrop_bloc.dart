import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
part 'movie_backdrop_event.dart';
part 'movie_backdrop_state.dart';

class MovieBackdropBloc extends Bloc<MovieBackdropEvent, MovieBackdropState> {
  MovieBackdropBloc() : super(MovieBackdropInitial()){
    on<MovieBackdropEventChanged>((event, emit)  {
        emit(MovieBackdropChanged(event.movie));
    });
  }
}
