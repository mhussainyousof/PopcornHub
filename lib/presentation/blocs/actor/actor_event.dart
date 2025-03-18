part of 'actor_bloc.dart';

sealed class ActorEvent extends Equatable {
  const ActorEvent();

  @override
  List<Object> get props => [];
}


class LoadActorsEvent extends ActorEvent{}