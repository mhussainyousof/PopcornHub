import 'package:equatable/equatable.dart';

class  MovieEntity extends Equatable {
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
}
