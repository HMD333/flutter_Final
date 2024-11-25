// import 'dart:ui_web';

import 'package:flutter/material.dart';

ThemeData LightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(162, 84, 55, 150),
    textTheme: const TextTheme(titleSmall: TextStyle(color: Colors.black)));

ThemeData DarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(162, 42, 27, 75),
    textTheme: const TextTheme(titleSmall: TextStyle(color: Colors.white)));
