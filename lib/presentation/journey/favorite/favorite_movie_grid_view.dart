import 'package:flutter/material.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/favorite/favorite_movie_card_widget.dart';

class FavoriteMovieGridView extends StatelessWidget {
  final List<MovieEntity> movies;

  const FavoriteMovieGridView(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, 
        itemCount: movies.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0,
            
              childAspectRatio: 0.7,
              crossAxisCount: 2),
        itemBuilder: (context, index) {
          return FavoriteMovieCardWidget(movie: movies[index]);
        });
  }
}
