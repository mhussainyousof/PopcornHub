import 'package:popcornhub/data/domain/entity/actor_entity.dart';

class ActorModel extends ActorEntity {
  ActorModel(
      {required super.id,
      required super.name,
      required super.profilePath,
      required super.popularity});

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? 'Unknown',
        profilePath: json['profile_path'] ?? '',
        popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_path': profilePath,
      'popularity': popularity,
    };
  }

    ActorEntity toEntity() {
    return ActorEntity(
      id: id,
      name: name,
      profilePath: profilePath,
      popularity: popularity,
    );
  }
}
