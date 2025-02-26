
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:popcornhub/common/constants/languages.dart';
import 'package:popcornhub/data/domain/entity/language_entity.dart';
import 'package:popcornhub/data/domain/entity/no_params.dart';
import 'package:popcornhub/data/domain/usecase/get_prefered_langauge.dart';
import 'package:popcornhub/data/domain/usecase/update_langauge.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetPreferedLangauge getPreferedLangauge;
  final UpdateLangauge updateLangauge;
  LanguageBloc({
    required this.getPreferedLangauge,
    required this.updateLangauge,
  }) : super(LanguageLoaded(Locale(Languages.languages[0].code))) {
    on<LanguageEvent>((event, emit) async {
      if (event is ToggleLanguageEvent) {
        await updateLangauge(event.language.code);
        add(LoadPreferedLanguageEvent());

        emit(LanguageLoaded(Locale(event.language.code)));
      } else if (event is LoadPreferedLanguageEvent) {
        final response = await getPreferedLangauge(NoParams());
        response.fold(
            (l) => emit(LanguageError()), (r) => emit(LanguageLoaded(Locale(r))));
      }
    });
  }
}
