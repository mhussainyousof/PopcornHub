import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/usecase/get_movie_detail.dart';
import 'package:popcornhub/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcornhub/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:popcornhub/presentation/blocs/laoding/loading_bloc.dart';
import 'package:popcornhub/presentation/blocs/videos/video_bloc.dart';
part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideoBloc videoBloc;
  final FavoriteBloc favoriteBloc;
  final LoadingBloc loadingBloc;
  MovieDetailBloc(
      {
      required this.loadingBloc,  
      required this.favoriteBloc,
      required this.videoBloc,
      required this.castBloc,
      required this.getMovieDetail})
      : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) async {
      if (event is MovieDetailLoadEvent) {
        loadingBloc.add(StartLoading());
        final Either<AppError, MovieDetailEntity> eitherRespnse =
            await getMovieDetail(MovieParams(event.movieId));
        return eitherRespnse.fold((failure) => emit(MovieDetailError()),
            (movie) {
          emit(MovieDetailLoaded(movie));
          castBloc.add(CastLoadedEvent(movieId: event.movieId));
          videoBloc.add(VideosLoadedEvent(movieId: event.movieId));
          favoriteBloc.add(CheckIfFavoriteMovie(movieId: event.movieId));
          loadingBloc.add(FinishLoading());
        });

      }
    });
  }
}
