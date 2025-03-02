import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_comming_soon.dart';
import 'package:popcornhub/data/domain/usecase/get_playingnow.dart';
import 'package:popcornhub/data/domain/usecase/get_popular.dart';

part 'movie_tabbed_event.dart';
part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetCommingSoon getCommingSoon;

  MovieTabbedBloc({
    required this.getCommingSoon,
    required this.getPlayingNow,
    required this.getPopular,
  }) : super(MovieTabbedInitial()) {
    on<MovieTabEventChanged>((event, emit) async {
      
        emit(MovieTabLoading(currentTabIndex: event.currentTabIndex));
      
      Either<AppError, List<MovieEntity>> moviesEither = Left(AppError(AppErrorType.network)); // Default value

      switch (event.currentTabIndex) {
        case 0:
          moviesEither = await getPopular(NoParams());
          break;
        case 1:
          moviesEither = await getPlayingNow(NoParams());
          break;
        case 2:
          moviesEither = await getCommingSoon(NoParams());
          break;
      }


      moviesEither.fold(
        (failure) => emit(MovieTabLoadError(
          currentTabIndex: event.currentTabIndex,
          failure.appErrorType)),
        (movies) => emit(MovieTabChanged(currentTabIndex: event.currentTabIndex, movies: movies)),
      );
    });
  }
}
