import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final int id;
  final String title;
  final num voteAverage;
  final String releaseDate;
  final String? overview;
  final String backdropPath;

  const MovieEntity(
      {required this.posterPath,
      required this.id,
      required this.title,
      required this.voteAverage,
      required this.releaseDate,
      required this.backdropPath,
      this.overview});

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;

  factory MovieEntity.fromMovieDetailEntity(MovieDetailEntity movieDetailEntity) {
    return MovieEntity(
        posterPath: movieDetailEntity.posterPath,
        id: movieDetailEntity.id,
        title: movieDetailEntity.title,
        voteAverage: movieDetailEntity.voteAverage,
        releaseDate: movieDetailEntity.releaseDate,
        backdropPath: movieDetailEntity.backdropPath);
  }
}
