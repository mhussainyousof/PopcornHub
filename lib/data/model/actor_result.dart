import 'package:popcornhub/data/model/actor_model.dart';

class ActorResultModel {
  final List<ActorModel> actors;
  ActorResultModel({
    required this.actors,
  });
  
  factory ActorResultModel.fromJson(Map<String, dynamic> json) {
    return ActorResultModel(
      actors: (json['results'] as List)
          .map((json) => ActorModel.fromJson(json))
          .where((actor)=>actor.profilePath.isNotEmpty)
          .toList(),
    );
  }

  
}
