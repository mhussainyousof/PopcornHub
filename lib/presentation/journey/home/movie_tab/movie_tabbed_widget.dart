import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/common/extensions/string_extensions.dart';
import 'package:popcornhub/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/movie_listview_builder.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/movie_tab_constants.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/tab_title_widget.dart';
import 'package:popcornhub/presentation/widget/app_error_widget.dart';

//! 🎬 MovieTabbedWidget: Displays movie categories with tabs 🎬
//! Allows users to switch between different movie tabs (e.g., Popular, Now Playing, Upcoming).

class MovieTabbedWidget extends StatefulWidget {
  const MovieTabbedWidget({super.key});

  @override
  State<MovieTabbedWidget> createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  
  //! Access the MovieTabbedBloc for state management
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);

  int currentIndex = 0; //! Stores the currently selected tab index

  @override
  void initState() {
    super.initState();
    //! Dispatch initial event to load movies for the first tab
    movieTabbedBloc.add(MovieTabEventChanged(currentTabIndex: currentIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 0.h),
          child: Column(
            children: [
              //! 🔹 Row of movie category tabs (Popular, Now Playing, etc.)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: MovieTabConstants.movieTabs
                    .map((tab) => TabTitleWidget(
                          title: tab.title,
                          onTap: () => _onTabTapped(tab.index), //! Handle tab tap
                          isSelected: tab.index == state.currentTabIndex,
                        ))
                    .toList(),
              ),
              SizedBox(height: 5.h),

              //! 🔄 If movies are loaded, show the movie list
              if (state is MovieTabChanged)
                state.movies?.isEmpty ?? true
                    //! ❌ Show "No Movies" text if the list is empty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            TranslationConstants.noMovies.t(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    //! ✅ Show the movie list if movies are available
                    : Expanded(child: MovieListviewBuilder(movies: state.movies!)),

              //! 🚨 If there's an error, show an error widget
              if (state is MovieTabLoadError)
                Expanded(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    onPressed: () => movieTabbedBloc.add(
                      MovieTabEventChanged(currentTabIndex: state.currentTabIndex!),
                    ),
                  ),
                ),

              //! ⏳ Uncomment below if you want a loading indicator
              // if (state is MovieTabLoading)
              // Expanded(child: Center(child: LoadingCircle(size: 120.w))),
            ],
          ),
        );
      },
    );
  }

  //! 🔄 Handles tab switching logic
  void _onTabTapped(int index) {
    movieTabbedBloc.add(MovieTabEventChanged(currentTabIndex: index));
  }
}
