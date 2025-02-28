import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_search_params.dart';
import 'package:popcornhub/data/domain/usecase/search_movie.dart';
part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;
  SearchMovieBloc({
    required this.searchMovies,
  }) : super(SearchMovieInitial()) {
    on<SearchMovieEvent>((event, emit) async {
      if (event is SearchTermChangesEvent) {
        if (event.searhcTerm.length > 2) {
          emit(SearchMovieLoading());
          final Either<AppError, List<MovieEntity>> response =
              await searchMovies(
                  MovieSearchParams(searchTerm: event.searhcTerm));

          response.fold((l) => emit(SearchMovieError(
            l.appErrorType
          )),
              (r) => emit(SearchMovieLoaded(movies: r)));
        }
      }
    });
  }
}
