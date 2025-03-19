import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class NavigationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.video_play), label: 'Explore'),
            NavigationDestination(
                icon: Icon(Iconsax.menu_board), label: 'Dashboard'),
          ],
        ),
      ),
      body: ExploreScreen(),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesBloc(getPopular: getItInstance())
        ..add(PopMovieLoadedEvent()),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: (context, state) {
              if (state is PopMovieLoadedState) {
                final movies = state.movies;
                return ExploreListview(
                  mainText: 'POPULAR',
                  movies: movies);

              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class ExploreListview extends StatelessWidget {
  const ExploreListview({
    super.key,
    required this.movies,
     this.height = 225,
     this.Container_color =  AppColor.deepPurple,
     required this.mainText,
     this.listview_height = 230,
  });

  final List<MovieEntity> movies;
  final double height;
  final Color? Container_color;
  final String mainText;
  final double listview_height;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.only(top: 12, left: 4, right: 4),
          decoration: BoxDecoration(
            color: Container_color,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:mainText.split("").map((char) {
              return Text(
                char,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: listview_height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieTitleWidget(movie: movie);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MovieTitleWidget extends StatelessWidget {
  const MovieTitleWidget({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl:
                      '${ApiConstants.baseImageUrl}${movie.posterPath}',
                  height: 190,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  left: 1,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(4),
                        color: AppColor.electricBlue),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Text(
                        movie.voteAverage
                            .toStringAsFixed(1),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!.copyWith(fontSize: 9),
                      ),
                    ),
                  )),
              Positioned(
                  right: 1,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(4),
                        color: AppColor.softCoral),
                    child: Text(
                      movie.releaseDate.substring(0, 4),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!.copyWith(fontSize: 9),
                    ),
                  )),
            ],
          ),
          SizedBox(height: 5,),
          Text(movie.title.intelliTrim(),
          style: Theme.of(context).textTheme.bodySmall!.apply(
            fontSizeFactor: 0.9
          ),
          ),
        ],
      ),
    );
  }
}
