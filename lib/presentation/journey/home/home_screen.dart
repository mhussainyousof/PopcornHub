import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_drawer.dart';
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
      body: SafeArea(
        child: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          bloc: movieCarouselBloc,
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! Movie Carousel
                  SizedBox(
                    height: size.height * 0.6,
                    child: MovieCarouselWidget(
                      movies: state.movies,
                      defaultIndex: state.defaultIndex,
                    ),
                  ),

                  const SizedBox(height: 16),

                  //! متن Mood
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Hey, what's your mood today?",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  //! ایموجی‌ها در لیست اسکرول عمودی
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        children: [
                          _buildMoodButton("🔥", "Action", 28, size),
                          _buildMoodButton("💔", "Romance",10749, size),
                          _buildMoodButton("😂", "Comedy", 35, size),
                          _buildMoodButton("😱", "Horror", 27, size),
                          _buildMoodButton("🚀", "Sci-Fi", 878, size),
                        ],
                      ),
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
    ),
  );
}

Widget _buildMoodButton(String emoji, String label, int genreId, Size size) {
  double buttonSize = size.width * 0.12; 

  return GestureDetector(
    onTap: () => _navigateToMood(label, genreId),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            emoji,
            style: TextStyle(fontSize: buttonSize * 0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    ),
  );
}
}