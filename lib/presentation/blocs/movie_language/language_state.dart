part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();
  
  @override
  List<Object> get props => [];
}

final class LanguageLoaded extends LanguageState {
  final Locale locale;
  const LanguageLoaded(this.locale);


  @override
  List<Object> get props => [locale.languageCode];
}

final class LanguageError extends LanguageState{

}

