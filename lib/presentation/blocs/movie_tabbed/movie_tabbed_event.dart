part of 'movie_tabbed_bloc.dart';

sealed class MovieTabbedEvent extends Equatable {
  const MovieTabbedEvent();

  @override
  List<Object> get props => [];
}


class MovieTabEventChanged extends MovieTabbedEvent{
  final int currentTabIndex;
  const MovieTabEventChanged({this.currentTabIndex = 0});
  @override
  List<Object> get props => [currentTabIndex];
}




