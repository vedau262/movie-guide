import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_guide/bloc/movie/movie_bloc.dart';
import 'package:movie_guide/bloc/movie/movie_event.dart';
import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/strings/strings.dart';
import 'package:movie_guide/ui/pages/movie_detail_page.dart';
import 'package:movie_guide/ui/widget/MoviesList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = context.read<MovieBloc>();
    movieBloc.add(FetchMovieEvent());

    SystemChrome.setEnabledSystemUIOverlays(
        [
          SystemUiOverlay.top, //This line is used for showing the bottom bar
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              /*appBar: AppBar(
                title: Text("Popular"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      movieBloc.add(FetchMovieEvent());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      navigateToAboutPage(context);
                    },
                  )
                ],
              ),*/
              body: Container(
                child: BlocListener<MovieBloc, MoviesState>(
                  listener: (context, state) {
                    if (state is MoviesErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<MovieBloc, MoviesState>(builder: (_, state) {
                      if (state is MoviesInitialState) {
                        return buildLoading();
                      } else if (state is MoviesLoadingState) {
                        return buildLoading();
                      } else if (state is MoviesLoadedState) {
                        return buildMoviesList(state);
                      } else if (state is MoviesErrorState) {
                        return buildErrorUi(state.message);
                      } else {
                        return buildLoading();
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
  Widget buildMoviesList(MoviesLoadedState state){
    return SingleChildScrollView(
      child:Column(children: [
        MovieList(AppStrings.popularMovieTitle, state.popularResponse.getResult()),
        MovieList(AppStrings.upcomingMovieTitle, state.upcomingResponse.getResult()),
      ],
    )
    );
  }

  void navigateToAboutPage(BuildContext context) {

  }
}
