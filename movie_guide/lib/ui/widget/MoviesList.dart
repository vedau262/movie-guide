import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/strings/strings.dart';
import 'package:movie_guide/ui/pages/movie_detail_page.dart';

class MovieList extends StatefulWidget {
  final List<Movie> movies;
  final String title;
  MovieList(
    this.title,
    this.movies
  );

  @override
  State<StatefulWidget> createState() {
    return MovieListState(this.title, this.movies);
  }
}

class MovieListState extends State<StatefulWidget>{

  final String title;

  final List<Movie> movies;
  MovieListState(this.title, this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.grey,
            child: Text(this.title,
                style: TextStyle(
                  fontSize: 20.0,
                  height: 2
                )
            ),
          ),
          _buildMoviesList(movies),
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