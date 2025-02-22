part of 'video_bloc.dart';

sealed class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

final class VideoInitial extends VideoState {}

final class VideoLoading extends VideoState {}

final class VideoError extends VideoState {}

final class VideoLoaded extends VideoState {
  final List<VideoEntity> videos;
  const VideoLoaded({required this.videos});

  @override
  List<Object> get props => [videos];
}
