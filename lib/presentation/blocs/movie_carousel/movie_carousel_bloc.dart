import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_trending.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;
  MovieCarouselBloc(
      {required this.movieBackdropBloc, required this.getTrending})
      : super(MovieCarouselInitial()) {
    on<MovieCarouselEvent>((event, emit) async {

      if (event is MovieCarouselLoadedEvent) {

        final movieEither = await getTrending(NoParams());
        
        movieEither.fold((failure) => emit(MovieCarouselError(
          failure.appErrorType
        )), (movies) {
          movieBackdropBloc
              .add(MovieBackdropEventChanged(movies[event.defaultIndex]));
          if (movies.isNotEmpty) {
            movieBackdropBloc.add(MovieBackdropEventChanged(
                movies[event.defaultIndex.clamp(0, movies.length - 1)]));
          }
          emit(MovieCarouselLoaded(
              movies: movies, defaultIndex: event.defaultIndex));
        });
      }
    });
  }
}
