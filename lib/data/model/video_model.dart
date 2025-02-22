import 'package:popcornhub/data/domain/entity/video_entity.dart';

class VideoModel extends VideoEntity {
  final String? id;
  final String? iso6391;
  final String? iso31661;
  @override
  final String key;
  final String name;
  final String? site;
  final int? size;
  @override
  final String type;

  const VideoModel({
    this.id,
    this.iso6391,
    this.iso31661,
    required this.key,
    required this.name,
    this.site,
    this.size,
    required this.type,
  }) : super(
          title: name,
          key: key,
          type: type,
        );

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    print("🔍 Debug: Raw Video Key -> ${json['key']} (${json['key'].runtimeType})"); // تست مقدار

    return VideoModel(
      id: json['id'] as String?,
      iso6391: json['iso_639_1'] as String?,
      iso31661: json['iso_3166_1'] as String?,
      key: json['key'].toString(), // **مطمئن شدن از تبدیل به String**
      name: json['name'] ?? '',
      site: json['site'] as String?,
      size: (json['size'] as int?) ?? 0, // مقدار `size` را نال‌سیف کنیم
      type: json['type'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iso_639_1': iso6391,
      'iso_316_6_1': iso31661,
      'key': key, // از قبل String هست
      'name': name,
      'site': site,
      'size': size ?? 0, // جلوگیری از نال بودن مقدار `size`
      'type': type,
    };
  }
}
