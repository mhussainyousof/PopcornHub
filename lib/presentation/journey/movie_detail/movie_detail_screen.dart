import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:popcornhub/presentation/journey/movie_detail/big_poster.dart';
import 'package:popcornhub/presentation/journey/movie_detail/movie_detail_arguments.dart';

class MovieDetailScreen extends StatefulWidget {
final   MovieDetailArguments movieDetailArguments;
 const MovieDetailScreen({super.key, required this.movieDetailArguments});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final MovieDetailBloc _movieDetailBloc;
  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieDetailBloc
        .add(MovieDetailLoadEvent(widget.movieDetailArguments.movieId));
  }

  @override
  void dispose() {
    super.dispose();
    _movieDetailBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MovieDetailBloc>.value(
        value: _movieDetailBloc,
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            {
              if (state is MovieDetailLoaded) {
                final movieDetail = state.movieDetailEntity;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(movie: movieDetail),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        movieDetail.overview,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
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
