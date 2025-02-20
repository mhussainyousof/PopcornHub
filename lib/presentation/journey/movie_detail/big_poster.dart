import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/extensions/num_extensions.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_appbar.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class BigPoster extends StatelessWidget {
  final MovieDetailEntity movie;
  const BigPoster({
    super.key,
    required this.movie,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).primaryColor
              ])),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
            width: ScreenUtil().screenWidth,
          ),
        ),
        Positioned(
            bottom: 0,
            left: 5,
            right: 0,
            child: ListTile(
              title: Text(
                movie.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(fontSizeFactor: 0.9),
              ),
              subtitle: Text(
                movie.releaseDate,
                style: Theme.of(context).textTheme.greySubtitle1,
              ),
              trailing: Text(movie.voteAverage.convertToPercentageString(),
                  style: Theme.of(context).textTheme.violetHeadline6),
            )),

            Positioned(
              right: 20.w,
              left: 20.w,
              top: ScreenUtil().statusBarHeight+ 15.h,

              child: MovieDetailAppbar())
      ],
    );
  }
}
