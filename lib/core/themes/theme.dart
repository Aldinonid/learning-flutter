import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.orange,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
        displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue,
      ),
    );
  }
}