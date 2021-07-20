import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:netflix/base/extension/time_extension.dart';
import 'package:netflix/base/theme/theme_manager.dart';
import 'package:netflix/config/config_base.dart';
import 'package:netflix/config/constants.dart';
import 'package:netflix/config/shared_preferences.dart';
import 'package:netflix/screen/home/components/card_home_widget.dart';
import 'package:netflix/screen/home/components/category_home_widget.dart';
import 'package:netflix/screen/theme_action.dart';
import 'package:netflix/screen/theme_bloc.dart';
import 'package:provider/provider.dart';
import 'package:netflix/utilities.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 0,
      leading:
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: Constant.DEFAULT_PADDING / 2),
          icon: Icon(Icons.nightlight_round),
          onPressed: () {
            // final themeChange = Provider.of<ThemeBloc>(context, listen: false);
            final themeBloc = context.read<ThemeBloc>();
            logDebug("current theme is light: ${themeBloc.isLightTheme.value} => set to ${!themeBloc.isLightTheme.value}");
            themeBloc.action.add(SetThemeAction(!themeBloc.isLightTheme.value));
            // SpUtil.getInstance().then((value) { useValue(value); });
          },
        ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constant.DEFAULT_PADDING / 2),
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () { },
          ),
        ),
      ],
    );
  }

  void useValue(SpUtil value) {
    bool isLightMode = value.getBool(keyThemeMode).getDefault();
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String b = timeStamp.timeFormat();
    logDebug("=============== isLightMode $isLightMode");
    logDebug("=============== Intl().locale ${ Intl().locale}");
    logDebug("=============== timeStamp $timeStamp");
    logDebug("=============== timeStamp.timeFormat() ${b}");
    
    String time = '2021-07-15';
    String time1 = '1626325341670';
    logDebug("=============== ${(time).convertStringToMillis(dateTimeFormat: 'yyyy-MM-dd')}");
    logDebug("=============== ${(time1).timeFormat(dateTimeFormat: 'yyyy MM dd')}");
    print(DateTime.parse('2018-09-07T17:29:12+02:00').toUtc());
    print(DateTime.parse('2021-07-15 13:46:13').toLocal());
    print(DateTime.parse(b));
  }



}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // it enable scroll on small device
    return Column(
      children: <Widget>[
        CategoryHome(),
        MovieCarousel()
      ],
    );
  }
}