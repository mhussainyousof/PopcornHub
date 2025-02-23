part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

final class  SearchTermChangesEvent extends SearchMovieEvent {
  final String searhcTerm;
  const SearchTermChangesEvent(this.searhcTerm);

  @override
  List<Object> get props => [searhcTerm];
}
