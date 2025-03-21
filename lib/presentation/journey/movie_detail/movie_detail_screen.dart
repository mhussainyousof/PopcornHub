import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/common/constants/route_constants.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcornhub/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:popcornhub/presentation/blocs/videos/video_bloc.dart';
import 'package:popcornhub/presentation/journey/movie_detail/big_poster.dart';
import 'package:popcornhub/presentation/journey/movie_detail/cast_widget.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';
import 'package:popcornhub/presentation/journey/movie_detail/videos_widget.dart';
import 'package:popcornhub/presentation/journey/watch_video/watch_video_arguments.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;
  const MovieDetailScreen({super.key, required this.movieDetailArguments});
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final MovieDetailBloc _movieDetailBloc;
  late final CastBloc _castBloc;
  late final VideoBloc _videoBloc;
  late final FavoriteBloc _favoriteBloc;
  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc
        .add(MovieDetailLoadEvent(widget.movieDetailArguments.movieId));
    _videoBloc = _movieDetailBloc.videoBloc;
    _castBloc = _movieDetailBloc.castBloc;
    _favoriteBloc = _movieDetailBloc.favoriteBloc;
  }

  @override
  void dispose() {
    super.dispose();
    _movieDetailBloc.close();
    _castBloc.close();
    _videoBloc.close();
    _favoriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailBloc),
          BlocProvider.value(value: _castBloc),
          BlocProvider.value(value: _videoBloc),
          BlocProvider.value(value: _favoriteBloc)
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            {
              if (state is MovieDetailLoaded) {
                final movieDetail = state.movieDetailEntity;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BigPoster(movie: movieDetail),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        child: Text(
                          movieDetail.overview,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          TranslationConstants.cast.t(context),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      CastWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: VideosWidget(videoBloc: _videoBloc),
                      ),
                    ],
                  ),
                );
              } else if (state is MovieDetailError) {
                return Container();
              }
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
