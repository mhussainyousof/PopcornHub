import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class SearchMovieCard extends StatelessWidget {
  final MovieEntity movie;
  const SearchMovieCard({
    super.key,
    required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteList.movieDetail,
            arguments: MovieDetailArguments(movieId: movie.id));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                scale: 5,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      movie.overview!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.greyCaption,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
