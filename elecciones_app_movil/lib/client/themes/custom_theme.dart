import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white70,
        highlightColor: Colors.grey,
        buttonTheme: ButtonThemeData(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.lightBlue,
        ));
  }

}
