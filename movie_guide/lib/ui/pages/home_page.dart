import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_guide/bloc/movie/movie_bloc.dart';
import 'package:movie_guide/bloc/movie/movie_event.dart';
import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'package:movie_guide/data/model/movies_response.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/src/widgets/box_button.dart';
import 'package:movie_guide/src/widgets/box_text.dart';
import 'package:movie_guide/src/widgets/input_field.dart';
import 'package:movie_guide/strings/strings.dart';
import 'package:movie_guide/ui/pages/movie_detail_page.dart';
import 'package:movie_guide/ui/widget/movie_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieBloc movieBloc;
  late List<MoviesResponse> responseList;

  @override
  void initState() {
    super.initState();
    movieBloc = context.read<MovieBloc>();
    movieBloc.add(FetchMovieEvent());
  }

  @override
  void dispose() {
    movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              backgroundColor: Colors.black54,
              /*appBar: AppBar(
                title: Text("Popular"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      // movieBloc.add(LoadMoreMovieEvent(AppStrings.popularMovieTitle));
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
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),

                  child: Column(
                    children: [
                      Text(
                        "MOVIE GUIDE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          height: 2,
                        ),

                      ),
                      Container(
                        child: BlocListener<MovieBloc, LoadingState>(
                          listener: (context, state) {
                            if (state is LoadMoviesErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            }
                          },
                          child: BlocBuilder<MovieBloc, LoadingState>(builder: (_, state) {
                            print("BlocBuilder home page");
                            if(state is LoadMovieState){
                              if(state.responseList.isEmpty){
                                return buildLoading();
                              }
                              else{
                                responseList = state.responseList;
                                return buildMoviesList(this.responseList);
                              }

                            } else {
                              print("buildMoviesList(inputState);");
                              return buildMoviesList(this.responseList);
                            }
                          },
                          ),
                        ),
                      ),
                    ],
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
      ],
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

  Widget buildMoviesList(List<MoviesResponse> responseList){
    List<MovieList> data = [];
    for (int i = 0; i < responseList.length; i++) {
      data.add(MovieList(responseList[i], movieBloc));
    }

    return SingleChildScrollView(
        child:Column(children: data
        )
    );
  }

  void navigateToAboutPage(BuildContext context) {

  }
}
