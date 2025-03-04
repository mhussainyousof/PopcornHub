import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/movie_tab_card_widget.dart';

//! 🎥 MovieListViewBuilder: Displays a horizontal list of movies 🎥
//! Uses ListView.separated to show movies in a scrollable format.

class MovieListviewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieListviewBuilder({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h), //! Adds vertical spacing
      child: ListView.separated(
        //! Enables horizontal scrolling
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: movies.length,

        //! Adds spacing between movie items
        separatorBuilder: (context, index) {
          return SizedBox(width: 14.w);
        },

        //! Builds each movie card dynamically
        itemBuilder: (context, index) {
          final MovieEntity movie = movies[index];

          return MovieTabCardWidget(
            movieId: movie.id, //! Pass movie ID
            posterPath: movie.posterPath, //! Pass poster image
            title: movie.title, //! Pass movie title
          );
        },
      ),
    );
  }
}
