import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_guide/bloc/movie/movie_bloc.dart';
import 'package:movie_guide/data/repository/movies_repository.dart';
import 'package:movie_guide/ui/pages/home_page.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket',
      home: BlocProvider(
        create: (_) => MovieBloc(repository: MoviesRepositoryImpl()),
        child: HomePage(),
      ),
    );
  }
}
