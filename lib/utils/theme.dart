import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  fontFamily: 'NunitoSans',
  primaryColor: Color.fromRGBO(46, 196, 182, 1),
  accentColor: Color.fromRGBO(27, 154, 170, 1),
  buttonColor: Color.fromRGBO(242, 243, 174, 1),
  errorColor: Color.fromRGBO(255, 34, 61, 1),
  colorScheme: ColorScheme(
      primary: Color.fromRGBO(46, 196, 182, 1),
      primaryVariant: Color.fromRGBO(27, 154, 170, 1),
      secondary: Color.fromRGBO(242, 243, 174, 1),
      secondaryVariant: Color.fromRGBO(242, 243, 174, 1),
      surface: Color.fromRGBO(0, 0, 0, 1),
      background: Color.fromRGBO(0, 0, 0, 1),
      error: Color.fromRGBO(255, 34, 61, 1),
      onPrimary: Color.fromRGBO(0, 0, 0, 1),
      onSecondary: Color.fromRGBO(45, 216, 76, 1),
      onSurface: Colors.black,
      onBackground: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark),
  brightness: Brightness.dark,
  backgroundColor: Color.fromRGBO(0, 0, 0, 1),
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
