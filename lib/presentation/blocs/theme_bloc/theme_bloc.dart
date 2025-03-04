import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'theme_event.dart';
part 'theme_state.dart';





class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  final Box settingsBox = Hive.box('settings'); 
  ThemeBloc() : super(ThemeMode.light) {
    on<ToggleThemeEvent>((event, emit) {
      final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      settingsBox.put('isDarkMode', newTheme == ThemeMode.dark); 
      emit(newTheme);
    });

    on<SetThemeEvent>((event, emit) { 
      emit(event.themeMode);
    });

    _loadTheme(); 
  }

  void _loadTheme() {
    final isDarkMode = settingsBox.get('isDarkMode', defaultValue: false) as bool;
    add(SetThemeEvent(isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }
}
