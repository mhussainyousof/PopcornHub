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
      // body: HomeScreen(),
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

class ExploreListview extends StatelessWidget {
  const ExploreListview({
    super.key,
    required this.movies,
    this.height = 180,
    this.Container_color = AppColor.deepPurple,
    required this.mainText,
    this.listview_height = 200,
    this.textDirection = TextDirection.ltr,
    this.left_height = 0,
  });

  final List<MovieEntity> movies;
  final double height;
  final Color? Container_color;
  final String mainText;
  final double listview_height;
  final double left_height;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13.0),
      child: Row(
        textDirection: textDirection,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: height,
            margin: EdgeInsets.only(right: 2, left: left_height),
            padding: const EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.deepPurple, AppColor.electricBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: AnimatedText(text: mainText), 
          ),
          Expanded(
            child: SizedBox(
              height: listview_height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return AnimatedMoviePicWidget(
                    movie: movie,
                    index: index,
                  ); 
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AnimatedText extends StatefulWidget {
  final String text;

  const AnimatedText({super.key, required this.text});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // تکرار انیمیشن

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.1, 0), // میزان لرزش
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.text.split("").map((char) {
          return Text(
            char,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
class AnimatedMoviePicWidget extends StatefulWidget {
  final MovieEntity movie;
  final int index;

  const AnimatedMoviePicWidget({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  _AnimatedMoviePicWidgetState createState() => _AnimatedMoviePicWidgetState();
}

class _AnimatedMoviePicWidgetState extends State<AnimatedMoviePicWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500 + (widget.index * 100)),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: MoviePicWidget(movie: widget.movie),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}




class MoviePicWidget extends StatelessWidget {
  const MoviePicWidget({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
              height: 190,
              width: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(
                backgroundColor: AppColor.mintGreen,
                color: AppColor.softCoral,
                strokeAlign: 1,
              ),),
              errorWidget: (context, url, error) => Icon(Iconsax.image),
            ),
          ),
          Positioned(
            left: 1,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.electricBlue.withOpacity(0.8), AppColor.softCoral.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 1,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.softCoral.withOpacity(0.8), AppColor.electricBlue.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                movie.releaseDate.substring(0, 4),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}