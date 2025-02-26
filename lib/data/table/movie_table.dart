import 'package:hive/hive.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';

part 'movie_table.g.dart';

@HiveType(typeId: 0)
class MovieTable extends MovieEntity {
  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String posterPath;

  const MovieTable({
    required this.posterPath,
    required this.id,
    required this.title,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPath,
          backdropPath: '',
          releaseDate: '',
          voteAverage: 0.0,
        );

  factory MovieTable.formMovieEntity(MovieEntity movieEntity) {
    return MovieTable(
        posterPath: movieEntity.posterPath,
        id: movieEntity.id,
        title: movieEntity.title);
  }
}
