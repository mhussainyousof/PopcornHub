part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();
  
  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}
final class MovieDetailLoading extends MovieDetailState{}
final class MovieDetailError extends MovieDetailState{}
final class MovieDetailLoaded extends MovieDetailState{
  final MovieDetailEntity movieDetailEntity;
  const MovieDetailLoaded(this.movieDetailEntity);


  @override
  List<Object> get props  => [movieDetailEntity];
  
  
}