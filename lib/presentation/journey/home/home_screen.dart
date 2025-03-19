import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/actor/actor_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/actor_movie/actor_mvoie.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_drawer.dart';
import 'package:popcornhub/presentation/journey/mood_movie/mood_movie.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
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
                    //! Movie Carousel
                    SizedBox(
                      height: size.height * 0.40,
                      child: MovieCarouselWidget(
                        movies: state.movies,
                        defaultIndex: state.defaultIndex,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitle(text: 'Or you vibe?'),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  genreId: 10749,
                                  size: size,
                                  onTap: (label, genreId) => _navigateToMood(
                                      label,
                                      genreId,
                                      "assets/lottie/sad.json")),
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
                    TextTitle(text: 'Or maybe stars?'),
                    const SizedBox(height: 12),
                    BlocBuilder<ActorBloc, ActorState>(
                        builder: (context, state) {
                      if (state is ActorLoading) {
                        return Center(child: LinearProgressIndicator());
                      }
                      if (state is ActorError) {
                        return Center(child: Text(state.message));
                      }
                      if (state is ActorLoaded) {
                        final actors = state.actors;

                        return SizedBox(
                          height: 140,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: actors.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 1),
                            itemBuilder: (context, index) {
                              final actor = actors[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ActorMoviesScreen(
                                              actorId: actor.id);
                                        }));
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: Image.network(
                                            '${ApiConstants.baseImageUrl}${actor.profilePath}',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          ))),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      actor.name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    })
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

class TextTitle extends StatelessWidget {
  const TextTitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: 18,
        color: AppColor.deepPurple,
        fontWeight: FontWeight.w800,
        shadows: [
          Shadow(
            blurRadius: 4,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
            offset: const Offset(2, 2),
          ),
        ],
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  final String label;
  final String imageAsset;
  final int genreId;
  final Size size;
  final Function(String, int) onTap;

  const MoodButton({
    Key? key,
    required this.label,
    required this.imageAsset,
    required this.genreId,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonSize = size.width * 0.20;
    final Color moodColor = _getMoodColor(label);

    return GestureDetector(
      onTap: () => onTap(label, genreId),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: "mood_$label",
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: moodColor.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Lottie.asset(
                  imageAsset,
                  repeat: true,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: moodColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(String label) {
    switch (label) {
      case '🔥':
        return Colors.redAccent;
      case '💔':
        return Colors.pinkAccent;
      case '😂':
        return Colors.amberAccent;
      case '😱':
        return Colors.deepPurpleAccent;
      case '🚀':
        return Colors.lightBlueAccent;
      default:
        return Colors.grey;
    }
  }
}
