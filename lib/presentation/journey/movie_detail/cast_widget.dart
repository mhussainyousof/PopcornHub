import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state is CastLoad) {
          return SizedBox(
            height: 230.h,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.casts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final castEntity = state.casts[index];
                  return SizedBox(
                    width: 130.w,
                    height: 140.h,
                    child: Card(
                      elevation: 1,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                              bottom: Radius.circular(13.r))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${ApiConstants.baseImageUrl}${castEntity.posterPath}',
                              height: 100.h,
                              width: 120.w,
                              fit: BoxFit.fitWidth,
                            ),
                          )
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              castEntity.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.vulcanBodyText2!.apply(
                                    fontSizeFactor: 0.9
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 3.h),
                            child: Text(
                              castEntity.character,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
