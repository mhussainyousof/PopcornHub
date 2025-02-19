part of 'movie_carousel_bloc.dart';

sealed class MovieCarouselState extends Equatable {
  const MovieCarouselState();
  
  @override
  List<Object> get props => [];
}

final class MovieCarouselInitial extends MovieCarouselState {}
final class MovieCarouselError extends MovieCarouselState{
   final AppErrorType errorType;
   const MovieCarouselError(this.errorType);
}
final class MovieCarouselLoaded extends MovieCarouselState{
  final List<MovieEntity> movies;
  final int defaultIndex;
  const MovieCarouselLoaded({
    this.movies = const [],
    this.defaultIndex = 0
  }) : assert(defaultIndex >= 0, 'It cannot be less than 0');

@override
List<Object> get props => [movies, defaultIndex];

}