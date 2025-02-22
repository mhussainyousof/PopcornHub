import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/domain/entity/video_entity.dart';
import 'package:popcornhub/presentation/journey/watch_video/watch_video_arguments.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WatchVideoScreen extends StatefulWidget {
  final WatchVideoArguments watchVideoArguments;

  const WatchVideoScreen({super.key, required this.watchVideoArguments});

  @override
  WatchVideoScreenState createState() => WatchVideoScreenState();
}

class WatchVideoScreenState extends State<WatchVideoScreen> {
  late final List<VideoEntity> _videos;
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _videos = widget.watchVideoArguments.videos;

    _controller = YoutubePlayerController(
      initialVideoId: _videos[0].key,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TranslationConstants.watchTrailers.t(context))),
      body: Column(
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
            builder: (context, player) => player,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) => VideoItem(
                video: _videos[index],
                onTap: () {
                  _controller.load(_videos[index].key);
                  _controller.play();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final VideoEntity video;
  final VoidCallback onTap;

  const VideoItem({super.key, required this.video, required this.onTap});

  // تابع موقتی برای نمایش زمان تصادفی (بعداً می‌تونیم API واقعی اضافه کنیم)
  String getFakeDuration() {
    final randomMinutes = (2 + (30 * (video.key.hashCode % 10) / 10)).toInt();
    final seconds = (10 + (50 * (video.key.hashCode % 5) / 5)).toInt();
    return "$randomMinutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: ListTile(
        onTap: onTap,
        leading: Stack(
          children: [
            CachedNetworkImage(
              width: 120,
              height: 70,
              imageUrl: YoutubePlayer.getThumbnail(
                videoId: video.key,
                quality: ThumbnailQuality.high,
              ),
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  getFakeDuration(), // زمان ویدیو
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          video.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
