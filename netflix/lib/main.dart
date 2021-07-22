import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:netflix/custom_view/tabbar/bottom_tab_bar.dart';
import 'package:netflix/network/service/movie_category/movie_repo.dart';
import 'package:netflix/screen/detail_movie/detail_movie_bloc.dart';
import 'package:netflix/screen/detail_movie/detail_movie_route.dart';
import 'package:netflix/screen/detail_movie/detail_movie_screen.dart';
import 'package:netflix/screen/home/home_bloc.dart';
import 'package:netflix/screen/home/home_route.dart';
import 'package:netflix/screen/tabbar/root_tabbar.dart';
import 'package:netflix/screen/theme_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'base/theme/theme_manager.dart';
import 'config/constants.dart';
import 'model/contact.dart';
import 'model/favourite.dart';
import 'model/movie.dart';
import 'utilities.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  logDebug("Handling a background message title: ${message.notification!.title}");
  logDebug("Handling a background message body: ${message.notification!.body}");
  logDebug("Handling a background message body: ${message.data}");
  storageManager.saveData(keyThemeMode, true);
}

void main() async{
  await initBox();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  return runApp(
  // ChangeNotifierProvider<ThemeNotifier>(
  //   create: (_) => new ThemeNotifier(),
  //   child: MyApp(),
  // )

    Provider<ThemeBloc>(
        create: (_) => ThemeBloc(),
        dispose: (_, bloc) => bloc.dispose(),
        child: MyApp(),
    )

  );
  // setupLocator();
  // runApp(MyApp());
}

Future initBox() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  // Hive.registerAdapter(ContactAdapter());
  // Hive.registerAdapter(FavouriteAdapter());
  Hive.registerAdapter(MovieAdapter());
  // await Hive.openBox<Contact>('contacts');
  // await Hive.openBox<Contact>('favourites');
  return;
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ThemeBloc>();
    return StreamBuilder<ThemeData>(
        stream: bloc.theme.stream,
        builder: (context, data) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movie App',
            theme: data.data,
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
          );
        }
    );

    /*return Consumer<ThemeNotifier>(
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
    );*/
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

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    final String viewType = 'hybrid-view-type';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
