import 'package:equatable/equatable.dart';

class ActorEntity extends Equatable {
  final String id;
  final String name;
  final String profilePath;
  final double popularity;
  ActorEntity({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
  });
  
  @override
  List<Object?> get props => [id, name];

  @override
  bool get stringify => true;
}
