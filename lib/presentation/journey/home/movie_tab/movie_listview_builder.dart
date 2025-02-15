import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/movie_tab_card_widget.dart';

class MovieListviewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;
  const MovieListviewBuilder({
    super.key,
    required this.movies,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 14.w,
          );
        },
        itemBuilder: (context, index) {
          final MovieEntity movie = movies[index];
          return MovieTabCardWidget(
              movieId: movie.id,
              posterPath: movie.posterPath,
              title: movie.title);
        },
      ),
    );
  }
}
