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

extension CustomColorScheme on ColorScheme {
  Color get primary => const Color.fromRGBO(46, 196, 182, 1);
  Color get primaryVariant => const Color.fromRGBO(27, 154, 170, 1);
  Color get secondary => const Color.fromRGBO(242, 243, 174, 1);
  Color get success => const Color.fromRGBO(48, 167, 69, 1);
  Color get surface => const Color.fromRGBO(0, 11, 19, 1);
  Color get background => const Color.fromRGBO(9, 20, 28, 1);
  Color get danger => const Color.fromRGBO(231, 29, 54, 1);
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
      surface: Color.fromRGBO(6, 20, 32, 1),
      background: Color.fromRGBO(9, 20, 28, 1),
      error: Color.fromRGBO(255, 34, 61, 1),
      onPrimary: Color.fromRGBO(0, 11, 19, 1),
      onSecondary: Color.fromRGBO(45, 216, 76, 1),
      onSurface: Colors.black,
      onBackground: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark),
  brightness: Brightness.dark,
  backgroundColor: Color.fromRGBO(9, 20, 28, 1),
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
