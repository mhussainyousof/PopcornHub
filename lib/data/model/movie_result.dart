import 'package:popcornhub/data/model/movie_model.dart';

class MovieResultModel {
  List<MovieModel> movies;
  MovieResultModel({
    this.movies = const [],
  });

  MovieResultModel.fromJson(Map<String, dynamic> json)
      : movies = (json['results'] as List?)
                ?.map((v) => MovieModel.fromJson(v))
                .toList() ??
            [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = movies.map((v) => v.toJson()).toList();
    return data;
  }
}
