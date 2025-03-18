import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

class MovieBackdropWidget extends StatelessWidget {
  const MovieBackdropWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.r), top:  Radius.circular(50.r)),
        child: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
                builder: (context, state) {
                  if (state is MovieBackdropChanged) {
                    String backdropPath = state.movie.backdropPath;
                    String posterPath = state.movie.posterPath;

                    String imageUrl = backdropPath.isNotEmpty
                        ? '${ApiConstants.baseImageUrl}$backdropPath'
                        : '${ApiConstants.baseImageUrl}$posterPath';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: SizedBox.expand(),
            )
          ],
        ),
      ),
    );
  }
}
