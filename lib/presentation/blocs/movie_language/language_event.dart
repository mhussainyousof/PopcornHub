part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}


final class ToggleLanguageEvent extends LanguageEvent{
  final LanguageEntity language;
  const ToggleLanguageEvent(this.language);

@override
  List<Object> get props => [language.code];
}