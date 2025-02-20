import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/usecase/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailBloc({required this.getMovieDetail}) : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit)async {
      if(event is MovieDetailLoadEvent){
        final Either<AppError, MovieDetailEntity> eitherRespnse = await getMovieDetail(MovieParams(event.movieId));
        return eitherRespnse.fold((failure)=> emit(MovieDetailError()), (movie){
          emit(MovieDetailLoaded(movie));
        });
      }
    });
  }
}
