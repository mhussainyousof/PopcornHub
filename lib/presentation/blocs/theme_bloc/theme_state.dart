part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object> get props => [];
}

final class LightThemeState extends ThemeState {}

final class DarkThemeState extends ThemeState {}
