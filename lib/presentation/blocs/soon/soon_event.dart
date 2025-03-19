part of 'soon_bloc.dart';

sealed class SoonEvent extends Equatable {
  const SoonEvent();

  @override
  List<Object> get props => [];
}


final class SoonLoadMovieEvent extends SoonEvent{}