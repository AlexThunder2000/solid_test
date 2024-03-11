import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));

  Future<void> initialTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? themeMode = prefs.getString('themeMode');

    switch (themeMode) {
      case 'dark':
        emit(const ThemeState(themeMode: ThemeMode.dark));
      default:
        emit(const ThemeState(themeMode: ThemeMode.light));
        break;
    }
  }

  Future<void> switchTheme() async {
    if (state.themeMode == ThemeMode.dark) {
      emit(const ThemeState(themeMode: ThemeMode.light));
    } else {
      emit(const ThemeState(themeMode: ThemeMode.dark));
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'themeMode',
      state.themeMode.toString().split('.').last,
    );
  }
}
