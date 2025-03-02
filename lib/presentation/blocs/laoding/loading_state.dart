part of 'loading_bloc.dart';

sealed class LoadingState extends Equatable {
  const LoadingState();
  
  @override
  List<Object> get props => [];
}

final class LoadingInitial extends LoadingState {}
final class LoadingStarted extends LoadingState {}
final class LoadingFinished extends LoadingState {}