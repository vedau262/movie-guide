import 'package:flutter/material.dart';
import 'package:netflix/custom_view/tabbar/bottom_tab_bar.dart';
import 'package:netflix/network/service/movie_category/movie_repo.dart';
import 'package:netflix/screen/detail_movie/detail_movie_bloc.dart';
import 'package:netflix/screen/detail_movie/detail_movie_route.dart';
import 'package:netflix/screen/detail_movie/detail_movie_screen.dart';
import 'package:netflix/screen/home/home_bloc.dart';
import 'package:netflix/screen/home/home_route.dart';
import 'package:netflix/screen/tabbar/root_tabbar.dart';
import 'package:provider/provider.dart';

import 'base/dependency_injection.dart';
import 'base/theme/theme_mamager.dart';
import 'model/movie.dart';

void main() {
  // startDartIn(appModule);
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: MyApp(),
  ));
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
              theme: theme.getTheme(),
          // theme: ThemeData(
          //   visualDensity: VisualDensity.adaptivePlatformDensity,
          // ),
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
      ),
    );
  }
}

class MyApp_1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        // theme: ThemeData(
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Hybrid Theme'),
          ),
          body: Row(
            children: [
              Container(
                child: FlatButton(
                  onPressed: () => {
                    print('Set Light Theme'),
                    theme.setLightMode(),
                  },
                  child: Text('Set Light Theme'),
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: () => {
                    print('Set Dark theme'),
                    theme.setDarkMode(),
                  },
                  child: Text('Set Dark theme'),
                ),
              ),
            ],
          ),
        ),
      ),
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
