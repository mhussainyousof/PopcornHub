part of 'cast_bloc.dart';

sealed class CastState extends Equatable {
  const CastState();
  
  @override
  List<Object> get props => [];
}

final class CastInitial extends CastState {}

final class CastLoad extends CastState {
  final List<CastEntity> casts;
  const CastLoad({
    required this.casts
  });

  @override 
  List<Object> get props => [casts];
}
final class CastError extends CastState {}
