part of 'movie_carousel_bloc.dart';

sealed class MovieCarouselEvent extends Equatable {
  const MovieCarouselEvent();

  @override
  List<Object> get props => [];
}

final class MovieCarouselLoadedEvent extends MovieCarouselEvent {
  final int defaultIndex;
  const MovieCarouselLoadedEvent({this.defaultIndex = 0});

  @override
  List<Object> get props => [defaultIndex];
}
