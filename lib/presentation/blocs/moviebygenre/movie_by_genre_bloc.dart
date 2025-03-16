import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/usecase/get_genre.dart';

part 'movie_by_genre_event.dart';
part 'movie_by_genre_state.dart';

class MovieByGenreBloc extends Bloc<MovieByGenreEvent, MovieByGenreState> {
  final GetMoviesByGenre getMoviesByGenre;

  MovieByGenreBloc({required this.getMoviesByGenre}) : super(MovieByGenreInitial()) {
    on<LoadMoviesByGenreEvent>((event, emit) async {
      emit(MovieByGenreLoading());

      final result = await getMoviesByGenre(event.params);

      result.fold(
        (error) => emit(MovieByGenreError(_mapErrorToMessage(error))),
        (movies) => emit(MovieByGenreLoaded(movies)),
      );
    });
  }

  String _mapErrorToMessage(AppError error) {
    switch (error.appErrorType) {
      case AppErrorType.network:
        return  TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.unauthorized:
        return 'Unauthorized';
      default:
        return 'Unexpected Error';
    }
  }
}

