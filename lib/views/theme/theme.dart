import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color.fromARGB(255, 255, 206, 57),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 206, 57),
  ),
  bottomAppBarTheme: const BottomAppBarThemeData(
    color: Color.fromARGB(255, 237, 236, 236),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Color.fromARGB(255, 255, 206, 57),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 32, 32, 32),
  ),
  bottomAppBarTheme: const BottomAppBarThemeData(
    color: Color.fromARGB(255, 32, 32, 32),
  ),
);
