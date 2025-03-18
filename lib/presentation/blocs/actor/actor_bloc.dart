import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/data/domain/entity/actor_entity.dart';
import 'package:popcornhub/data/domain/entity/app_erro.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_actor.dart';

part 'actor_event.dart';
part 'actor_state.dart';

class ActorBloc extends Bloc<ActorEvent, ActorState> {
  final GetActors getActors;

  ActorBloc({
    required this.getActors,
  }) : super(ActorInitial()) {
    on<LoadActorsEvent>(_onLoadActors);
  }

  Future<void> _onLoadActors(
    LoadActorsEvent event,
    Emitter<ActorState> emit,
  ) async {
    emit(ActorLoading());

    final actorsEither = await getActors(NoParams());

    actorsEither.fold(
      (error) => emit(ActorError(_mapErrorToMessage(error.appErrorType))),
      (actors) => emit(ActorLoaded(actors)),
    );
  }

  String _mapErrorToMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      default:
        return "Unexpected Error";
    }
  }
}
