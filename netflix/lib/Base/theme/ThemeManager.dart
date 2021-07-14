import 'package:flutter/material.dart';
import 'package:netflix/config/constants.dart';
import 'package:netflix/utilities.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
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

  ThemeData? _themeData ;
  bool isLightTheme = true ;

  ThemeData getTheme() {
    if(_themeData!=null)
      return _themeData!;
    else return lightTheme;
  }

  ThemeNotifier() {
    sharePreferences.readData(keyThemeMode).then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? keyLightMode;
      if (themeMode == keyLightMode) {
        _themeData = lightTheme;
        isLightTheme = true;
        print('setting light theme');
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
        isLightTheme = false;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    isLightTheme = false;
    sharePreferences.saveData(keyThemeMode, keyDarkMode);
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    isLightTheme = true;
    sharePreferences.saveData(keyThemeMode, keyLightMode);
    notifyListeners();
  }
}