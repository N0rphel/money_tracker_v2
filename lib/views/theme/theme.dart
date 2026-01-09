import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color.fromARGB(255, 255, 206, 57),
  scaffoldBackgroundColor: const Color.fromARGB(255, 252, 248, 248),
  dividerColor: Colors.grey[350],
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.light,
    onPrimary: Colors.black,
    onSurface: Colors.grey[100],
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
  scaffoldBackgroundColor: Colors.black12,
  dividerColor: Colors.grey[800],
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.dark,
    onPrimary: Colors.white,
    onSurface: Colors.grey[100],
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 32, 32, 32),
  ),
  bottomAppBarTheme: const BottomAppBarThemeData(
    color: Color.fromARGB(255, 32, 32, 32),
  ),
);
