part of 'movie_tabbed_bloc.dart';

sealed class MovieTabbedState extends Equatable {
  final int? currentTabIndex;
  const MovieTabbedState({ this.currentTabIndex});
  
  @override
  List<Object> get props => [currentTabIndex!];
}

final class MovieTabbedInitial extends MovieTabbedState {
}
final class MovieTabChanged extends MovieTabbedState{
  final List<MovieEntity> movies;
  const MovieTabChanged(
    {required super.currentTabIndex,required this.movies,}

    );

    @override
    List<Object> get props => [movies, currentTabIndex!];
}


final class MovieTabLoadError extends MovieTabbedState {
  const MovieTabLoadError({super.currentTabIndex,});

}