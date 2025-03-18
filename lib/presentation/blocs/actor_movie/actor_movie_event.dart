part of 'actor_movie_bloc.dart';

sealed class ActorMovieEvent extends Equatable {
  const ActorMovieEvent();

  @override
  List<Object> get props => [];
}


final class LoadedActorMovieEvent extends ActorMovieEvent{
  final int actorId;
  LoadedActorMovieEvent({required this.actorId});

  @override
    List<Object> get props => [actorId];

}
