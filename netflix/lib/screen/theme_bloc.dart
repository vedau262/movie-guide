import 'package:flutter/material.dart';
import 'package:netflix/base/base_bloc.dart';
import 'package:netflix/base/preference/storage_manager.dart';
import 'package:netflix/config/constants.dart';
import 'package:netflix/screen/theme_action.dart';
import 'package:rxdart/rxdart.dart';

class ThemeBloc extends BaseBloc {
  //Input
  final PublishSubject<ThemeAction> action = PublishSubject<ThemeAction>();
  final BehaviorSubject<ThemeData> theme = BehaviorSubject<ThemeData>.seeded(lightTheme);
  final BehaviorSubject<bool> isLightTheme = BehaviorSubject<bool>.seeded(true);

  @override
  void dispose() {
    super.dispose();
    action.close();
    theme.close();
  }

  ThemeBloc(){
    storageManager.readData(keyThemeMode).then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? true;
      if (themeMode == true) {
        theme.value = lightTheme;
        isLightTheme.value = true;
        print('setting light theme');
      } else {
        print('setting dark theme');
        theme.value = darkTheme;
        isLightTheme.value = false;
      }
    });

    action.listen((ThemeAction event) {
      if(event is SetThemeAction){
        setTheme(event.isLightTheme);
      }
    });
  }

  void setTheme(bool isLight) async {
    theme.value = isLight? lightTheme : darkTheme;
    isLightTheme.value = isLight;
    storageManager.saveData(keyThemeMode, isLight);
  }
}

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

