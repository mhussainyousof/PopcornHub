import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_trending.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  MovieCarouselBloc({required this.getTrending}) : super(MovieCarouselInitial()) {
    on<MovieCarouselEvent>((event, emit) async{
      if(event is MovieCarouselLoadedEvent){     
        final movieEither = await getTrending(NoParams());
        movieEither.fold((failure)=>emit(MovieCarouselError()), (movies){
          emit(MovieCarouselLoaded(
            movies: movies,
            defaultIndex: event.defaultIndex
          ));
        });
      }
    });
  }
}
