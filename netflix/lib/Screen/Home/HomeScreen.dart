import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Base/theme/ThemeManager.dart';
import 'package:netflix/config/ConfigBase.dart';
import 'package:netflix/Screen/Home/Components/CardHomeWidget.dart';
import 'package:netflix/Screen/Home/Components/CategoryHomeWidget.dart';
import 'package:provider/provider.dart';

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
          final themeChange = Provider.of<ThemeNotifier>(context, listen: false);
          print("current theme is light: ${themeChange.isLightTheme}");
          if(themeChange.isLightTheme){
            themeChange.setDarkMode();
          } else {
            themeChange.setLightMode();
          }

        },
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constant.DEFAULT_PADDING / 2),
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
      ],
    );
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