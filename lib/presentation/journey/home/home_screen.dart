import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
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

  @override
  void initState() {
    super.initState();

    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    searchMovieBloc = getItInstance<SearchMovieBloc>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;

    movieCarouselBloc.add(MovieCarouselLoadedEvent());
  }

  @override
  void dispose() {
    movieCarouselBloc.close();
    movieBackdropBloc.close();
    searchMovieBloc.close();
    super.dispose();
  }

  void _navigateToMood(String mood, int genreId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  MoodMoviesScreen(   
        moodName: mood,
        genreId: genreId, 
      ),
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
    ],
    child: Scaffold(
      drawer: NavigationDrawerr(),
      body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
        bloc: movieCarouselBloc,
        builder: (context, state) {
          if (state is MovieCarouselLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //! Movie Carousel
                SizedBox(
                  height: size.height * 0.55,
                  child: MovieCarouselWidget(
                    movies: state.movies,
                    defaultIndex: state.defaultIndex,
                  ),
                ),
      
                //! متن Mood
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Hey, what's your mood today?",
                    style:Theme.of(context).textTheme.titleMedium
                  ),
                ),
      
                const SizedBox(height: 12),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: [
                      _buildMoodButton("🔥", "assets/lottie/action.json", 28, size),
                      // _buildMoodButton("🔥", "assets/lottie/action2.json", 28, size),
                      _buildMoodButton("💔", "assets/lottie/sad.json",10749, size),
                      _buildMoodButton("😂", "assets/lottie/fun.json", 35, size),
                      _buildMoodButton("😱", "assets/lottie/horror.json", 27, size),
                      _buildMoodButton("🚀", "assets/lottie/fiction.json", 878, size),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MovieCarouselError) {
            return AppErrorWidget(
              onPressed: () =>
                  movieCarouselBloc.add(MovieCarouselLoadedEvent()),
              errorType: state.errorType,
            );
          }
      
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ),
  );
}

Widget _buildMoodButton(String label, String imageAsset, int genreId, Size size, ) {

  double buttonSize = size.width * 0.20;
  final Color moodColor = _getMoodColor(label);

  return GestureDetector(
    onTap: () => _navigateToMood(label, genreId),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: label,
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
            child: 
            Lottie.asset(            
              imageAsset,
              repeat: true,
              fit: BoxFit.contain,
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