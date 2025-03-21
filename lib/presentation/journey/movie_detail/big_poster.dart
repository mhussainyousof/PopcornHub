import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_appbar.dart';
import 'package:popcornhub/presentation/journey/movie_detail/videos_widget.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

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
        Positioned(
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: AppColor.charcoalGrey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12.r),
            ),


            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      movie.releaseDate,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(Iconsax.star, size: 16.sp, color: AppColor.mintGreen),
                    SizedBox(width: 5.w),
                    Text(
                      movie.voteAverage.toStringAsFixed(1), 
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.mintGreen,
                      ),
                    ),
                   
                  ],
                ),
              ],
            ),
          ),
        ),
       
         Positioned(
            top: ScreenUtil().statusBarHeight + 20.h,
            right: 40.w,
            left: 40.w,
            child: MovieDetailAppbar(movieDetailEntity: movie))
      ],
    );
  }
}








// class BigPoster extends StatelessWidget {
//   final MovieDetailEntity movie;
//   const BigPoster({
//     super.key,
//     required this.movie,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           foregroundDecoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                 AppColor.richBlack.withAlpha(60),
//                 AppColor.richBlack
//               ])),
//           child: CachedNetworkImage(
//             imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
//             width: ScreenUtil().screenWidth,
//           ),
//         ),
//         Positioned(
//             bottom: 0,
//             left: 5,
//             right: 0,
//             child: ListTile(
//               title: Text(
//                 movie.title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleLarge!
//                     .apply(fontSizeFactor: 0.9, color: Colors.white),
//               ),
//               subtitle: Text(
//                 movie.releaseDate,
//                 style: Theme.of(context).textTheme.greySubtitle1,
//               ),
//               trailing: Text(movie.voteAverage.convertToPercentageString(),
//                   style: Theme.of(context).textTheme.violetHeadline6),
//             )),
//         Positioned(
//             right: 20.w,
//             left: 20.w,
//             top: ScreenUtil().statusBarHeight + 15.h,
//             child: MovieDetailAppbar(movieDetailEntity: movie))
//       ],
//     );
//   }
// }


