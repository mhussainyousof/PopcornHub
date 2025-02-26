import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/presentation/blocs/videos/video_bloc.dart';
import 'package:popcornhub/presentation/journey/watch_video/watch_video_arguments.dart';
import 'package:popcornhub/presentation/journey/watch_video/watch_video_screen.dart';
import 'package:popcornhub/presentation/widget/button.dart';

class VideosWidget extends StatelessWidget {
  final VideoBloc videoBloc;
  const VideosWidget({super.key, required this.videoBloc});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      bloc: videoBloc,
      builder: (context, state) {
        if (state is VideoLoaded && state.videos.iterator.moveNext()) {
          final videos = state.videos;
          return Button(
              text: TranslationConstants.watchTrailers,
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.watchTrailer, arguments: WatchVideoArguments(videos));
              //  Navigator.of(context).push(MaterialPageRoute(builder: (context)
              //  => WatchVideoScreen(watchVideoArguments: WatchVideoArguments(videos))
              //  ));
              });
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
