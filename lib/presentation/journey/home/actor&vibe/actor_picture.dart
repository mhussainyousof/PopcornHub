
import 'package:flutter/material.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/actor_entity.dart';
import 'package:popcornhub/presentation/journey/actor_movie/actor_mvoie.dart';

class ActorPicture extends StatelessWidget {
  const ActorPicture({
    super.key,
    required this.actor,
  });

  final ActorEntity actor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) {
              return ActorMoviesScreen(
                  actorId: actor.id);
            }));
          },
          child: Container(
            width: 70, 
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                '${ApiConstants.baseImageUrl}${actor.profilePath}',
                fit: BoxFit
                    .cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelSmall,
          ),
        ),
      ],
    );
  }
}

