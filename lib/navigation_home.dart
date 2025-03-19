import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/blocs/playing_now/playing_now_bloc.dart';
import 'package:popcornhub/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:popcornhub/presentation/blocs/soon/soon_bloc.dart';
import 'package:popcornhub/presentation/journey/explore/explore_cubit.dart';
import 'package:popcornhub/presentation/journey/explore/widgets/explore_listview.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class NavigationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>NavigationCubit(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return Padding(
          padding: const EdgeInsets.all(8.0),
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected:(index){
              context.read<NavigationCubit>().updateIndex(index);
            } ,
            destinations: [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Iconsax.video_play), label: 'Explore'),
              NavigationDestination(
                  icon: Icon(Iconsax.menu_board), label: 'Dashboard'),
            ],
          ),
        );
          },
        ),
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            switch(currentIndex){
              case 0: 
              return HomeScreen();
              case 1:
              return ExploreScreen();
              case 2:
              return Placeholder();
              default:
              return HomeScreen();
            } 
          },
        )
      ),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularMoviesBloc(getPopular: getItInstance())
            ..add(PopMovieLoadedEvent()),
        ),
        BlocProvider(
          create: (context) => PlayingNowBloc(getPlayingNow: getItInstance())
            ..add(NowLoadMovieEvent()),
        ),
        BlocProvider(
          create: (context) => SoonBloc(getCommingSoon: getItInstance())
            ..add(SoonLoadMovieEvent()),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                  builder: (context, state) {
                    if (state is PopMovieLoadedState) {
                      final movies = state.movies;
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ExploreListview(
                          height: 190,
                            mainText: 'POPULAR', movies: movies),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                BlocBuilder<PlayingNowBloc, PlayingNowState>(
                  builder: (context, state) {
                    if (state is NowLoadedMovieState) {
                      final movies = state.movies;
                      return ExploreListview(
                          left_height: 2,
                          height: 180,
                          textDirection: TextDirection.rtl,
                          movies: movies,
                          mainText: 'Now');
                    }
                    return SizedBox.shrink();
                  },
                ),
                BlocBuilder<SoonBloc, SoonState>(
                  builder: (context, state) {
                    if (state is SoonLoadedMovieState) {
                      final movies = state.movies;
                      return ExploreListview(
                          height: 180, movies: movies, mainText: 'SOON');
                    }
                    return SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



