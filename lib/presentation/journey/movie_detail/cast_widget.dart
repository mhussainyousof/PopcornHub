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
    final theme = Theme.of(context);

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

                return Container(
                  width: 130.w,
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Card(
                    elevation: 1,
                    color: theme.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                        bottom: Radius.circular(13.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: '${ApiConstants.baseImageUrl}${castEntity.posterPath}',
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                castEntity.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 12.sp,
                                  color: theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                castEntity.character,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

