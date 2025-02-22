import 'video_model.dart';

class VideoResultModel {
  final int id;
  late final List<VideoModel> videos;

  VideoResultModel({required this.id, required this.videos});

  factory VideoResultModel.fromJson(Map<String, dynamic> json) {
    var videos = <VideoModel>[];

    if (json['results'] != null) {
      json['results'].forEach((v) {
        var videoModel = VideoModel.fromJson(v);
        if (_isValidVideo(videoModel)) {
          videos.add(videoModel); // **فقط یک‌بار مقداردهی کنیم**
        }
      });
    }

    return VideoResultModel(id: json['id'], videos: videos);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'results': videos.map((v) => v.toJson()).toList(),
    };
  }
}

bool _isValidVideo(VideoModel videoModel) {
  return videoModel.key.isNotEmpty &&
      videoModel.name.isNotEmpty &&
      videoModel.type.isNotEmpty;
}
