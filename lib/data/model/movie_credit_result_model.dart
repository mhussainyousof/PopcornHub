import 'package:popcornhub/data/model/movie_model.dart';

class MovieCreditResultModel {
  List<MovieModel> cast;

  MovieCreditResultModel({
    this.cast = const [],
  });

  factory MovieCreditResultModel.fromJson(Map<String, dynamic> json) {
    return MovieCreditResultModel(
      cast: (json['cast'] as List?)
              ?.map((v) => MovieModel.fromJson(v))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cast'] = cast.map((v) => v.toJson()).toList();
    return data;
  }
}
