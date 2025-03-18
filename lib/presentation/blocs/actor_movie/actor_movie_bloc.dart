import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/usecase/get_movie_by_actor.dart';

part 'actor_movie_event.dart';
part 'actor_movie_state.dart';

class ActorMovieBloc extends Bloc<ActorMovieEvent, ActorMovieState> {
  final GetMovieByActor getMovieByActor;
  ActorMovieBloc({
    required this.getMovieByActor
  }) : super(ActorMovieInitial()) {
    on<ActorMovieEvent>((event, emit) async{
      if(event is LoadedActorMovieEvent){
              final eitherMovies  =  await  getMovieByActor(MovieParams(event.actorId));

          eitherMovies.fold(
          (error){
            emit(ErrorActorMovie(message: error.appErrorType.toString()));

          },(movies){
            emit(
              LoadedActorMovie(movies: movies)
            );
          }
          );
      }
    });
  }
}
