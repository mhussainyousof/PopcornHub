part of 'loading_bloc.dart';

sealed class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}
final class StartLoading extends LoadingEvent {} 
final class FinishLoading extends LoadingEvent {}
