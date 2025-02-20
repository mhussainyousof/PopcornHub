part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

}


final class MovieDetailLoadEvent extends MovieDetailEvent{
  final int movieId;
  const MovieDetailLoadEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
  
}
