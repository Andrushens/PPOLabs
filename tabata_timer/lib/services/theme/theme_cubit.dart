import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tabata_timer/services/theme/themes.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  bool isDark() => state == darkTheme;

  void changeTheme() {
    emit(
      state == lightTheme
          ? darkTheme
          : state == lightThemeBig
              ? darkThemeBig
              : state == darkTheme
                  ? lightTheme
                  : lightThemeBig,
    );
  }

  void changeFont() {
    emit(
      state == lightTheme
          ? lightThemeBig
          : state == lightThemeBig
              ? lightTheme
              : state == darkTheme
                  ? darkThemeBig
                  : darkTheme,
    );
  }
}
