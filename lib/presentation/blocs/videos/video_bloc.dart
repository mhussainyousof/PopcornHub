import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/entity/video_entity.dart';
import 'package:popcornhub/data/domain/usecase/get_videos.dart';
part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetVideos getVideos;
  VideoBloc({required this.getVideos}) : super(VideoInitial()) {
    on<VideoEvent>((event, emit) async {
      if (event is VideosLoadedEvent) {
       final Either<AppError, List<VideoEntity>> eitherVideos =
            await getVideos(MovieParams(event.movieId));
        eitherVideos.fold(
          (l) =>
            emit(VideoError()),
          
          (r) => emit(VideoLoaded(videos: r)),
        );
      }
    });
  }
}
