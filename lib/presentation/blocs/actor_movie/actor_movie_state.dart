part of 'actor_movie_bloc.dart';

sealed class ActorMovieState extends Equatable {
  const ActorMovieState();
  
  @override
  List<Object> get props => [];
}

final class ActorMovieInitial extends ActorMovieState {}
final class LoadedActorMovie extends ActorMovieState {
  
  final List<MovieEntity> movies;
  LoadedActorMovie({required this.movies});
    @override
  List<Object> get props => [movies];

}
final class LoadingActorMovie extends ActorMovieState {}
final class ErrorActorMovie extends ActorMovieState {
  final String message;
  ErrorActorMovie({required this.message});
   @override
  List<Object> get props => [message];
}


