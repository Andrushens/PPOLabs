import 'package:flutter/material.dart';

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white, fontSize: 28),
    headline2: TextStyle(color: Colors.white, fontSize: 28),
    bodyText1: TextStyle(color: Colors.white, fontSize: 24),
    bodyText2: TextStyle(color: Colors.white, fontSize: 24),
  ),
);

var darkThemeBig = darkTheme.copyWith(
  textTheme: TextTheme(
    headline1: darkTheme.textTheme.headline1!.copyWith(
      fontSize: darkTheme.textTheme.headline1!.fontSize! + 4,
    ),
    headline2: darkTheme.textTheme.headline2!.copyWith(
      fontSize: darkTheme.textTheme.headline2!.fontSize! + 4,
    ),
    bodyText1: darkTheme.textTheme.bodyText1!.copyWith(
      fontSize: darkTheme.textTheme.bodyText1!.fontSize! + 4,
    ),
    bodyText2: darkTheme.textTheme.bodyText2!.copyWith(
      fontSize: darkTheme.textTheme.bodyText2!.fontSize! + 4,
    ),
  ),
);

var lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black, fontSize: 28),
    headline2: TextStyle(color: Colors.black, fontSize: 28),
    bodyText1: TextStyle(color: Colors.black, fontSize: 24),
    bodyText2: TextStyle(color: Colors.black, fontSize: 24),
  ),
);

var lightThemeBig = lightTheme.copyWith(
  textTheme: TextTheme(
    headline1: lightTheme.textTheme.headline1!.copyWith(
      fontSize: lightTheme.textTheme.headline1!.fontSize! + 4,
    ),
    headline2: lightTheme.textTheme.headline2!.copyWith(
      fontSize: lightTheme.textTheme.headline2!.fontSize! + 4,
    ),
    bodyText1: lightTheme.textTheme.bodyText1!.copyWith(
      fontSize: lightTheme.textTheme.bodyText1!.fontSize! + 4,
    ),
    bodyText2: lightTheme.textTheme.bodyText2!.copyWith(
      fontSize: lightTheme.textTheme.bodyText2!.fontSize! + 4,
    ),
  ),
);
