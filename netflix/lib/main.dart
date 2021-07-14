import 'package:flutter/material.dart';
import 'package:netflix/CustomView/Tabbar/BottomTabBar.dart';
import 'package:netflix/Network/Service/MovieCategory/MovieRepo.dart';
import 'package:netflix/Screen/DetailMovie/DetailMovieBloc.dart';
import 'package:netflix/Screen/DetailMovie/DetailMovieRoute.dart';
import 'package:netflix/Screen/DetailMovie/DetailMovieScreen.dart';
import 'package:netflix/Screen/Home/HomeBloc.dart';
import 'package:netflix/Screen/Home/HomeRoute.dart';
import 'package:netflix/Screen/Tabbar/RootTabbar.dart';
import 'package:provider/provider.dart';

import 'Base/dependency_injection.dart';
import 'Model/Movie.dart';

void main() {
  // startDartIn(appModule);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeRoute.routeId,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeRoute.routeId:
            return MaterialPageRoute(
              builder: (context) {
                return RootTabbar();
              }
            );
          case DetailMovieRoute.routeId:
            var arguments = settings.arguments as Movie;
            return MaterialPageRoute(
              builder: (context) {
                return MultiProvider(
                  providers: [
                    Provider<DetailMovieBloc>(
                        create: (_) => DetailMovieBloc(arguments),
                        dispose: (_, bloc) => bloc.dispose()),
                  ],
                  child: DetailMovieScreen(),
                );
              },
            );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      )
    );
  }
}
