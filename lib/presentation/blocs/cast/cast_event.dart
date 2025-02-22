part of 'cast_bloc.dart';

sealed class CastEvent extends Equatable {
  const CastEvent();
}


final class CastLoadedEvent extends CastEvent{
final int movieId;
const CastLoadedEvent({required this.movieId});

@override
List<Object> get props => [movieId];
}