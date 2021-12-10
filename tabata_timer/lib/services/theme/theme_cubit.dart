import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tabata_timer/services/theme/themes.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  bool isDark() => state == darkTheme;

  void changeTheme() {
    emit(state == lightTheme ? darkTheme : lightTheme);
  }
}
