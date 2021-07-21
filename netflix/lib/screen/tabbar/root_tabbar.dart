import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/base/push_notification_service.dart';
import 'package:netflix/main.dart';
import 'package:netflix/config/config_base.dart';
import 'package:netflix/custom_view/tabbar/bottom_tab_bar.dart';
import 'package:netflix/network/service/movie_category/movie_repo.dart';
import 'package:netflix/screen/favourist/favourist_screen.dart';
import 'package:netflix/screen/home/home_bloc.dart';
import 'package:netflix/screen/home/home_screen.dart';
import 'package:netflix/screen/match/match_bloc.dart';
import 'package:netflix/screen/match/match_screen.dart';
import 'package:provider/provider.dart';

class RootTabbar extends StatefulWidget {
  RootTabbar({Key? key}) : super(key: key);

  @override
  _RootTabbarState createState() => _RootTabbarState();
}

class _RootTabbarState extends State<RootTabbar> {
  List<Widget> listScreens = [];
  int _currentIndex = 0;
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  PushNotificationService service = PushNotificationService();

  @override
  void initState() {
    super.initState();
    service.setupInteractedMessage();
    MovieRepo movieRepo = MovieRepo();
    listScreens = [
      MultiProvider(
        providers: [
          Provider<HomeBloc>(
              create: (_) => HomeBloc(movieRepo),
              dispose: (_, bloc) => bloc.dispose()),
        ],
        child: HomeScreen(),
      ),
      Provider<MatchBloc>(
          create: (_) => MatchBloc(),
          child: MatchPage(title: 'MatchPage'),
          dispose: (_, bloc) => bloc.dispose()
      ),

      Provider<HomeBloc>(
        create: (_) => HomeBloc(movieRepo),
        child: FavouritePage(title: 'FavouritePage'),
        dispose: (_, bloc) => bloc.dispose()
      ),
      MyHomePage(title: '4215656')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: listScreens.length,
          child: Scaffold(
            body: IndexedStack(index: _currentIndex, children: listScreens),
            bottomNavigationBar: BottomTabBar(
              selectedIndex: _currentIndex,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              onItemSelected: (index) =>
                  setState(() {
                    _currentIndex = index;
                  }),
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.apps),
                  title: Text('Category'),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text(
                    'Favorite',
                  ),
                  inactiveColor: Colors.grey,
                  activeColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
      ),
    );
  }
}
