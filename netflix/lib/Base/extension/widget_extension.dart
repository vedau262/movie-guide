import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on Widget{
  Widget paddingOnly({double left=0.0, double right=0.0, double top = 0.0, double bottom = 0.0}){
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }

  Widget paddingDirection({double vertical = 0.0, double horizontal = 0.0}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }

  Widget paddingAll({double padding = 0.0}){
    return Padding(
        padding: EdgeInsets.all(padding),
        child: this,
    );
  }

  Widget marginOnly({double left=0.0, double right=0.0, double top = 0.0, double bottom = 0.0}){
    return Container(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }

  Widget marginAll({double margin = 0.0}){
    return Container(
      margin: EdgeInsets.all(margin),
      child: this,
    );
  }

  Widget marginDirection({double vertical = 0.0, double horizontal = 0.0}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }
}