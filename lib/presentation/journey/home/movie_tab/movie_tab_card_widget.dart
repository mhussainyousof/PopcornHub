import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class MovieTabCardWidget extends StatelessWidget {
  final int movieId;
  final String title, posterPath;
  const MovieTabCardWidget({
    super.key,
    required this.movieId,
    required this.posterPath,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).brightness;
    final isDark = themeMode == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteList.movieDetail,
            arguments: MovieDetailArguments(movieId: movieId));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.baseImageUrl}$posterPath',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
              child: Text(
                title.intelliTrim(),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .whiteBodyText2!
                    .apply(color: isDark ? Colors.white : AppColor.vulcan),
              ))
        ],
      ),
    );
  }
}
