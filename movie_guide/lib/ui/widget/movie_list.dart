import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_guide/bloc/movie/movie_bloc.dart';
import 'package:movie_guide/bloc/movie/movie_event.dart';
import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'package:movie_guide/data/model/movies_response.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/strings/strings.dart';
import 'package:movie_guide/ui/pages/movie_detail_page.dart';

class MovieList extends StatefulWidget {
  MoviesResponse response;
  MovieBloc movieBloc;

  MovieList(
    this.response,
    this.movieBloc
  );

  @override
  State<StatefulWidget> createState() {
    return MovieListState(response, movieBloc);
  }
}

class MovieListState extends State<MovieList>{
  MovieBloc movieBloc;
  MoviesResponse response;

  MovieListState(this.response, this.movieBloc);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Text(this.response.title.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  height: 2
                )
            ),
          ),

          Container(
            child: BlocBuilder<MovieBloc, PostState>(builder: (_, state) {
              if(state is UpdateMovieState && state.response.title == this.response.title){
                print("UpdateMovieState for ${state.response.title}");
                return Column(
                    children: [
                      ElevatedButton(
                        child: Text("load more"),
                        onPressed: (){
                          print("state.responseList ${state.response.title}");
                          movieBloc.add(LoadMoreMovieEvent(state.response));
                        },
                      ),
                       _buildMoviesList(state.response.getResult()),
                    ],
              );

            } else {
                return Column(
                  children: [
                    ElevatedButton(
                      child: Text("load more"),
                      onPressed: (){
                        movieBloc.add(LoadMoreMovieEvent(this.response));
                      },
                    ),
                    _buildMoviesList(response.getResult()),
                  ],
                );
              }
            },
          ),
          ),

          // _buildMoviesList(response.getResult()),
        ],
      ),
    );
  }
  
  Widget _buildMoviesList(List<Movie> movies){
    return Container(
        height: 200,
        // width: 200,
      // height: MediaQuery.of(context).size.height/5,
      child: ListView.builder(
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, pos) {
          return Container(

            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Container(
              child: InkWell(
                child:  Image.network(
                    movies[pos].getPosterPath(),

                  fit: BoxFit.fitHeight,
                ),
                onTap: () {
                  navigateToMovieDetailPage(context, movies[pos]);
                },
              ),
            ),
          );
        },
      )
    );
  }

  void navigateToMovieDetailPage(BuildContext context, Movie movie) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailPage(movie: movie);
    }));
  }
}