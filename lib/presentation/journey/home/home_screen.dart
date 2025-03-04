import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:popcornhub/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcornhub/presentation/journey/drawer/navigation_drawer.dart';
import 'package:popcornhub/presentation/widget/app_error_widget.dart';
import 'package:popcornhub/presentation/journey/home/movie_carousel/movie_carousel_widget.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/movie_tabbed_widget.dart';
import 'package:popcornhub/presentation/widget/button.dart';

//!  HomeScreen: The main dashboard of the app 🎬
//! Displays movie carousel, tabs, and handles navigation.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //! Bloc instances for managing different UI sections
  late final MovieCarouselBloc movieCarouselBloc;
  late final MovieBackdropBloc movieBackdropBloc;
  late final MovieTabbedBloc movieTabbedBloc;
  late final SearchMovieBloc searchMovieBloc;

  @override
  void initState() {
    super.initState();

    //! Initializing blocs using dependency injection
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    searchMovieBloc = getItInstance<SearchMovieBloc>();
    movieTabbedBloc = getItInstance<MovieTabbedBloc>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropBloc;

    //! Load movie carousel when screen initializes
    movieCarouselBloc.add(MovieCarouselLoadedEvent());
  }

  @override
  void dispose() {
    //! Closing blocs to free up memory
    movieCarouselBloc.close();
    movieBackdropBloc.close();
    movieTabbedBloc.close();
    searchMovieBloc.close();
    super.dispose();
  }

  //! 🔥 Handle back button press to show exit confirmation dialog
  Future<bool> _onWillPop() async {
    return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    'Exit App',
                    textAlign: TextAlign.center,
                  ),
                  content: Text('Do you want to exit the app?'),
                  actions: [
                    //! "No" Button: Close dialog, stay in the app
                    Button(
                        text: TranslationConstants.no,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                    //! "Yes" Button: Exit the app completely
                    Button(
                        text: TranslationConstants.yes,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          SystemNavigator.pop();
                        })
                  ],
                )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {  
    return WillPopScope(
      //! Attach exit confirmation to the back button
      onWillPop: _onWillPop,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => movieCarouselBloc),
          BlocProvider(create: (context) => movieBackdropBloc),
          BlocProvider(create: (context) => movieTabbedBloc),
          BlocProvider(create: (context) => searchMovieBloc),
        ],
        child: Scaffold(
          drawer: NavigationDrawerr(), //! Sidebar menu for navigation

          //! Movie Carousel & Tab Section
          body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
            bloc: movieCarouselBloc,
            builder: (context, state) {
              if (state is MovieCarouselLoaded) {
                //! 🎥 Movie carousel and tab layout
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    //! Movie Carousel (Top 57% of screen)
                    FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.57,
                      child: MovieCarouselWidget(
                        movies: state.movies,
                        defaultIndex: state.defaultIndex,
                      ),
                    ),

                    //! Movie Tabs (Bottom 43% of screen)
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.43,
                        child: MovieTabbedWidget(),
                      ),
                    ),
                  ],
                );
              } else if (state is MovieCarouselError) {
                //! 🔴 Show error widget if movies fail to load
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
      ),
    );
  }
}
