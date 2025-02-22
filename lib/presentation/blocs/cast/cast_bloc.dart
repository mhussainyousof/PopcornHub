import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/cast_entity.dart';
import 'package:popcornhub/data/domain/entity/movie_params.dart';
import 'package:popcornhub/data/domain/usecase/get_cast.dart';
part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getCast;
  CastBloc({required this.getCast}) : super(CastInitial()) {
    on<CastEvent>((event, emit) async {
      if (event is CastLoadedEvent) {
        Either<AppError, List<CastEntity>> eitherResponse =
            await getCast(MovieParams(event.movieId));
        eitherResponse.fold((l) => emit(CastError()), (r) => emit(CastLoad(casts: r)));
      }
    });
  }
}
