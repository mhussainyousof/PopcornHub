import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/presentation/blocs/videos/video_bloc.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_appbar.dart';
import 'package:popcornhub/presentation/journey/watch_video/watch_video_arguments.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class BigPoster extends StatelessWidget {
  final MovieDetailEntity movie;
  final VideoBloc videoBloc;
  const BigPoster({
    super.key,
    required this.movie,
    required this.videoBloc,
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
                Colors.transparent,
                AppColor.richBlack.withOpacity(0.7),
              ],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
            width: ScreenUtil().screenWidth,
            fit: BoxFit.cover,
          ),
        ),

        // Appbar Positioned
        Positioned(
          top: ScreenUtil().statusBarHeight + 20.h,
          right: 20.w,
          left: 20.w,
          child: MovieDetailAppbar(movieDetailEntity: movie),
        ),

        //! Movie Info Box Positioned
        Positioned(
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColor.charcoalGrey.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                SizedBox(height: 8.h),

                //! Row with release date, rating, and watch trailer button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //! Release Date
                    Text(
                      movie.releaseDate,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                    ),

                    SizedBox(width: 12.w),

                    //! Rating with Icon
                    Row(
                      children: [
                        Icon(Iconsax.star, size: 18.sp, color: AppColor.mintGreen),
                        SizedBox(width: 4.w),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.mintGreen,
                              ),
                        ),
                      ],
                    ),

                    Spacer(),

                    //! Watch Trailer Button
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RouteList.watchTrailer,
                          arguments: WatchVideoArguments(videoBloc.state is VideoLoaded
                              ? (videoBloc.state as VideoLoaded).videos
                              : []),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white70, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r), 
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      ),
                      icon: Icon(Iconsax.play, size: 18.sp),
                      label: Text(
                        TranslationConstants.watchTrailers.t(context),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
