import 'package:popcornhub/data/domain/entity/movie_entity.dart';

class MovieModel extends MovieEntity {
  final String? backdropPath;
  final String? originalTitle;
  final String? mediaType;
  final bool? adult;
  final String? originalLanguage;
  final List<int>? genreIds;
  final num? popularity;
  final bool? video;
  final int? voteCount;

  const MovieModel({
    required super.posterPath,
    required super.id,
    required super.title,
    required super.voteAverage,
    required super.releaseDate,
    super.overview,
    this.backdropPath,
    this.originalTitle,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.video,
    this.voteCount,
  });



  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      posterPath: json['poster_path'] ?? "",
      id: json['id'] ?? 0,
      title: json['title'] ?? "Unknown",
      voteAverage: (json['vote_average'] as num?) ?? 0.0,
      releaseDate: json['release_date'] ?? "Unknown",
      overview: json['overview'],
      backdropPath: json['backdrop_path'],
      originalTitle: json['original_title'],
      mediaType: json['media_type'],
      adult: json['adult'],
      originalLanguage: json['original_language'],
      genreIds: (json['genre_ids'] as List?)?.map((e) => e as int).toList() ?? [],
      popularity: (json['popularity'] as num?) ?? 0.0,
      video: json['video'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'poster_path': posterPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'backdrop_path': backdropPath,
      'media_type': mediaType,
      'adult': adult,
      'original_language': originalLanguage,
      'genre_ids': genreIds?.isNotEmpty == true ? genreIds : null, // جلوگیری از مقدار `[]`
      'popularity': popularity,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    }..removeWhere((key, value) => value == null); // حذف مقادیر `null`
  }
}
