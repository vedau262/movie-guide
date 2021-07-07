
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_guide/data/model/movie.dart';

class MovieDetailPage extends StatelessWidget {

  Movie movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {

    double screen_width = MediaQuery.of(context).size.width;
    double backdrop_height = screen_width * 9/ 16;
    print("screen_width: $screen_width screen_height: $backdrop_height");
    print("movie.getBackdropPath(): ${movie.getBackdropPath()}");

    return Scaffold(
     /* appBar: AppBar(
        // title: Text("Cricket"),
      ),*/
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Image.network(
              movie.getBackdropPath(),
              width: screen_width,
              height: backdrop_height,
              fit: BoxFit.fill,
            ),

            IconButton(
              color: Colors.white,
              padding: EdgeInsets.only(top: 25),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)
            ),
            
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(top: backdrop_height-backdrop_height/4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          movie.getPosterPath(),
                          width: screen_width/3,
                        ),
                      ),

                      Expanded(child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("${movie.title}",
                              overflow: TextOverflow.ellipsis,
                              // maxLines: 1,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.redAccent,
                                height: 3,
                              ),
                            ),

                            Text("User score: ${movie.voteAverage}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),

                  Text(
                    "Story",
                    style: TextStyle(
                      fontSize: 20,
                      height: 2,
                    ),
                  ),

                  Text(
                    "${movie.overview}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}
