import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/route_constants.dart';

import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String posterPath;
  const MovieCardWidget({
    super.key,
    required this.movieId,
    required this.posterPath,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(RouteList.movieDetail, arguments: MovieDetailArguments(movieId: movieId));
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => MovieDetailScreen(
          //         movieDetailArguments:
          //             MovieDetailArguments(movieId: movieId))));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.w),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.baseImageUrl}$posterPath',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
