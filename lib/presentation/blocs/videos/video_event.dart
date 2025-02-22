part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}


final class VideosLoadedEvent extends VideoEvent{
  final int movieId;
  const VideosLoadedEvent({required this.movieId});

  @override 
  List<Object> get props => [movieId];
}