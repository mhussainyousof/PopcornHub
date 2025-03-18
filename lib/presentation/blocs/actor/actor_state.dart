part of 'actor_bloc.dart';

sealed class ActorState extends Equatable {
  const ActorState();
  
  @override
  List<Object> get props => [];
}

final class ActorInitial extends ActorState {}
class ActorLoading extends ActorState {}
class ActorLoaded extends ActorState{
  final List<ActorEntity> actors;
  ActorLoaded(this.actors);

  @override
  List<Object> get props => [actors];
}

class ActorError extends ActorState{
  final String message;
  ActorError(this.message);

  @override
  List<Object> get props => [message];
} 