part of 'theme_bloc.dart';


sealed class ThemeEvent {
  const ThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent {}

class SetThemeEvent extends ThemeEvent { 
  final ThemeMode themeMode;
  const SetThemeEvent(this.themeMode);
}
