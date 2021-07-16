

import 'dart:ffi';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netflix/config/config_base.dart';
import 'package:netflix/base/extension/text_extension.dart';
import 'package:netflix/config/constants.dart';
import 'package:netflix/model/favourite.dart';
import 'package:netflix/model/movie.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:netflix/screen/home/home_state.dart';
import 'package:rxdart/rxdart.dart';

import '../home_bloc.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Constant.DEFAULT_PADDING / 2),
      child: buildMovieCard(context),
    );
  }

  Column buildMovieCard(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.7,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [Constant.DEFAULT_SHADOW],
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "${ConfigBase.BASE_IMAGE_URL}${movie.posterPath}",


                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Constant.DEFAULT_PADDING),
            child:Text(
              movie.title.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),


            ),
          ),
        Flexible(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: FutureBuilder(
                      future: Hive.openBox<Favourite>('favourites'),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasError){
                            return Container(
                              child: Text(snapshot.error.toString() ),
                            );
                          }
                          else return Container(child:
                             IconButton(
                               icon: Icon(CupertinoIcons.heart),
                               onPressed: () { addToFavourite(movie);  },
                             ),
                          );
                          // return Text("nnnnnnnnnnnnnnnnnnnnnnnnn");
                        } else {
                          return Container(
                            child: Text("Empty"),
                          );
                        }
                      },
                    ),
                  ),
                  Icon(Icons.star),
                  SizedBox(width: 5),
                  Text(
                    '${movie.voteAvg?.toDouble().toString()} (${movie.voteCount} votes)',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }

  void addToFavourite(Movie movie) {
      final favouriteBox = Hive.box<Movie>(hiveMovieFileName);
      favouriteBox.add(movie);
  }
}

class MovieCarousel extends StatefulWidget {
  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  PageController _pageController = PageController(
    // so that we can have small portion shown on left and right side
    viewportFraction: 0.75,
    // by default our movie poster
    initialPage: 0,
  );

  @override
  void didChangeDependencies() {
    final bloc = Provider.of<HomeBloc>(context);
    bloc.movieSelectedIndex.listen((index) {
      try {
        _pageController.jumpToPage(index);
      } catch (e) {}
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);
    return StreamBuilder(
        stream: Rx.combineLatest2(bloc.listMovie, bloc.movieSelectedIndex,
            (listMovie, movieSelectedIndex) => Void),
        builder: (context, stateData) {
          var listMovie = bloc.listMovie.value;
          if (listMovie.isNotEmpty) {
            return Flexible(
              flex: 1,
              child: PageView.builder(
                  onPageChanged: (value) {
                    bloc.movieSelectedIndex.add(value);
                  },
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  itemCount: listMovie.length,
                  // we have 3 demo movies
                  itemBuilder: (context, index) => buildMovieSlider(
                        listMovie,
                        index,
                        bloc.movieSelectedIndex.value,
                      )),
            );
          } else {
            return Container();
          }
        });
  }

  Widget buildMovieSlider(
          List<Movie> listMovie, int index, int selectedIndex) =>
      AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          final bloc = Provider.of<HomeBloc>(context);
          return Container(
            child: InkWell(
              onTap: (){
                print("SelectMovieAction");
                bloc.action.add(SelectMovieAction(context, listMovie[index]));
              },
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 350),
                opacity: 1,
                child: Transform.rotate(
                  angle: 0,
                  child: MovieCard(movie: listMovie[index]),
                ),
              )
            ),
          );
        },
      );
}
