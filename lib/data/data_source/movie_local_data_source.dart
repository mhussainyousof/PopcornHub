import 'package:hive/hive.dart';
import 'package:popcornhub/data/table/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<void> saveMovie(MovieTable movieTable);
  Future<List<MovieTable>> getMovies();
  Future<void> deleteMovie(int movieId);
  Future<bool> checkIfMovieFavorite(int movieId);
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  final Box<MovieTable> movieBox = Hive.box<MovieTable>('movieBox');
  @override
  Future<bool> checkIfMovieFavorite(int movieId) async {
    return movieBox.containsKey(movieId);
  }

  @override
  Future<void> deleteMovie(int movieId) async {
    await movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getMovies() async {
    final movieIds = movieBox.keys;
    List<MovieTable> movies = [];
    for (var movieId in movieIds) {
      movies.add(movieBox.get(movieId)!);
    }
    return movies;
  }

  @override
  Future<void> saveMovie(MovieTable movieTable) async {
    movieBox.put(movieTable.id, movieTable);
  }
}
