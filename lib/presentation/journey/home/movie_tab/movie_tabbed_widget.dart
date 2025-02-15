import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/movie_listview_builder.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/movie_tab_constants.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/tab_title_widget.dart';

class MovieTabbedWidget extends StatefulWidget {
  const MovieTabbedWidget({super.key});
  @override
  State<MovieTabbedWidget> createState() => _MovieTabbedWidgetState();
}
class _MovieTabbedWidgetState extends State<MovieTabbedWidget>
    with SingleTickerProviderStateMixin {
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);
  
  @override
  void initState() {
    super.initState();
    movieTabbedBloc.add(MovieTabEventChanged(currentTabIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 0.h),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: MovieTabConstants.movieTabs.map((tab)=>
                   TabTitleWidget(
                        title: tab.title,
                        onTap: () => _onTabTapped(tab.index),
                        isSelected: tab.index ==
                            state.currentTabIndex)
                   ).toList()
              ),
              SizedBox(
                height: 5.h,
              ),
              if (state is MovieTabChanged)
                Expanded(child: MovieListviewBuilder(movies: state.movies))
            ],
          ),
        );
      },
    );
  }

  void _onTabTapped(int index) {
    movieTabbedBloc.add(MovieTabEventChanged(currentTabIndex: index));
  }
}
