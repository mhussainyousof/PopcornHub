import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/actor/actor_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_drawer.dart';
import 'package:popcornhub/presentation/journey/home/actor&vibe/actor_picture.dart';
import 'package:popcornhub/presentation/journey/home/actor&vibe/mood_button.dart';
import 'package:popcornhub/presentation/journey/home/actor&vibe/text_title.dart';
import 'package:popcornhub/presentation/journey/mood_movie/mood_movie.dart';
import 'package:popcornhub/presentation/widget/app_error_widget.dart';
import 'package:popcornhub/presentation/journey/home/movie_carousel/movie_carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MovieCarouselBloc movieCarouselBloc;
  late final MovieBackdropBloc movieBackdropBloc;
  late final SearchMovieBloc searchMovieBloc;
  late final ActorBloc actorBloc;

  @override
  void initState() {
    super.initState();

    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    searchMovieBloc = getItInstance<SearchMovieBloc>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;
    actorBloc = getItInstance<ActorBloc>();
    movieCarouselBloc.add(MovieCarouselLoadedEvent());
    actorBloc.add(LoadActorsEvent());
  }

  @override
  void dispose() {
    movieCarouselBloc.close();
    movieBackdropBloc.close();
    searchMovieBloc.close();
    super.dispose();
    actorBloc.close();
  }

  void _navigateToMood(String mood, int genreId, String imageAsset) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: MoodMoviesScreen(
                moodName: mood,
                genreId: genreId,
                imageAsset: imageAsset,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => movieCarouselBloc),
        BlocProvider(create: (context) => movieBackdropBloc),
        BlocProvider(create: (context) => searchMovieBloc),
        BlocProvider(create: (context) => actorBloc),
      ],
      child: Scaffold(
        drawer: NavigationDrawerr(),
        body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          bloc: movieCarouselBloc,
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    TextTitle(
                      text: 'Trendings?',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //! Movie Carousel
                    SizedBox(
                      height: size.height * 0.38,
                      child: MovieCarouselWidget(
                        movies: state.movies,
                        defaultIndex: state.defaultIndex,
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    //! Actors
                    TextTitle(text: 'Stars?'),
                    const SizedBox(height: 5),
                    BlocBuilder<ActorBloc, ActorState>(
                      builder: (context, state) {
                        if (state is ActorLoaded) {
                          final actors = state.actors;
                          return SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: actors.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final actor = actors[index];
                                return ActorPicture(actor: actor);
                              },
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),

                    SizedBox(height: 16),
                    //! vibes
                        TextTitle(text: 'Or your vibe?'),
                        const SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            spacing: 16,
                            children: [
                              MoodButton(
                                  label: "🔥",
                                  imageAsset: "assets/lottie/action.json",
                                  genreId: 28,
                                  size: size,
                                  onTap: (label, genreId) => _navigateToMood(
                                      label,
                                      genreId,
                                      "assets/lottie/action.json")),
                              MoodButton(
                                  label: "😂",
                                  imageAsset: "assets/lottie/fun.json",
                                  genreId: 35,
                                  size: size,
                                  onTap: (label, genreId) => _navigateToMood(
                                      label,
                                      genreId,
                                      'assets/lottie/fun.json')),
                              MoodButton(
                                  label: "💔",
                                  imageAsset: "assets/lottie/sad.json",
                                  genreId: 18,
                                  size: size,
                                  onTap: (label, genreId) => _navigateToMood(
                                      label,
                                      genreId,
                                      "assets/lottie/sad.json")),
                              MoodButton(
                                  label: "👨‍👩‍👧‍👦",
                                  imageAsset: "assets/lottie/family.json",
                                  genreId: 10751,
                                  size: size,
                                  onTap: (label, genreId) => _navigateToMood(
                                      label,
                                      genreId,
                                      "assets/lottie/family.json")),
                              MoodButton(
                                  label: "😱",
                                  imageAsset: "assets/lottie/horror.json",
                                  genreId: 27,
                                  size: size,
                                  onTap: (label, genreId) => _navigateToMood(
                                      label,
                                      genreId,
                                      'assets/lottie/horror.json')),
                              MoodButton(
                                  label: "🚀",
                                  imageAsset: "assets/lottie/fiction.json",
                                  genreId: 878,
                                  size: size,
                                  onTap: (label, genreId) => _navigateToMood(
                                      label,
                                      genreId,
                                      'assets/lottie/fiction.json')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              );
            } else if (state is MovieCarouselError) {
              return AppErrorWidget(
                onPressed: () =>
                    movieCarouselBloc.add(MovieCarouselLoadedEvent()),
                errorType: state.errorType,
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
