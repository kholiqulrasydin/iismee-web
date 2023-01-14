import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  backgroundColor: Colors.white,
  primaryColor: Colors.blueAccent,
  primaryColorDark: Colors.blueGrey,
  hintColor: Colors.blueGrey.shade600,
  iconTheme: IconThemeData(
    color: Colors.blueGrey.shade600
  ),
  brightness: Brightness.light
);

final darkTheme = ThemeData(
  backgroundColor: Colors.blueGrey.shade800,
  primaryColor: Colors.blueAccent,
  primaryColorDark: Colors.blueGrey,
  hintColor: Colors.blueGrey.shade200,
  iconTheme: IconThemeData(
    color: Colors.blueGrey.shade200
  ),
  brightness: Brightness.dark
);