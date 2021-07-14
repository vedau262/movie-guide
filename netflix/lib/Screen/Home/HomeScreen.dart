import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Base/loading_dialog.dart';
import 'package:netflix/Config/ConfigBase.dart';
import 'package:netflix/Screen/Home/Components/CardHomeWidget.dart';
import 'package:netflix/Screen/Home/Components/CategoryHomeWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading:
      IconButton(
        padding: EdgeInsets.symmetric(horizontal: Constant.DEFAULT_PADDING / 2),
        color: Colors.black,
        icon: Icon(Icons.notifications),
        onPressed: () {
          print("tap vao thong bao");
        },
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constant.DEFAULT_PADDING / 2),
          child: IconButton(
            color: Colors.black,
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