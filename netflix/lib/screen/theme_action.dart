import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ThemeAction {}

class SetThemeAction extends ThemeAction {
  final bool isLightTheme;
  SetThemeAction(this.isLightTheme);
}

