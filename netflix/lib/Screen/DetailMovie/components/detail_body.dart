import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Base/BaseBloc.dart';
import 'package:netflix/Base/base_view.dart';
import 'package:netflix/Base/body_widget.dart';
import 'package:netflix/Base/dependency_injection.dart';
import 'package:netflix/Base/loading_dialog.dart';
import 'package:netflix/Screen/DetailMovie/detail_state.dart';
import 'package:netflix/config//ConfigBase.dart';
import 'package:netflix/config/Result.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/Network/APIResponse.dart';
import 'package:netflix/Screen/DetailMovie/detail_movie_bloc.dart';
import 'package:netflix/Screen/DetailMovie/components//video_trailer.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/model/trailer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';
import 'package:netflix/utilities.dart';

class DetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:Body()
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieDetailPage();

}


class MovieDetailPage extends BaseState<DetailMovieBloc, Body>{

  @override
  DetailMovieBloc getBloc() {
    return Provider.of<DetailMovieBloc>(context);
  }

  @override
  void initBloc() {
    bloc.action.add(GetDetailAction(bloc.movie.id ?? 0));
  }

  @override
  Widget buildWidget(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double backdropHeight = screenWidth * 9 / 16;
    Movie movie = bloc.movie;
    print("build detail");

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Image.network(
              movie.getBackdropPath(),
              width: screenWidth,
              height: backdropHeight,
              fit: BoxFit.fill,
            ),

            IconButton(
                padding: EdgeInsets.only(top: 25),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)
            ),

            Container(
              // color: Colors.red,
              // padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: backdropHeight - backdropHeight / 4,
                  bottom: 16,
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetail(movie),
                  TrailerBody(context, bloc.trailer).getBuilder(),
                  PlayTrailerBody(context, bloc.trailerVideoId).getBuilder(),
                ],
              ),
            ),
          ],
        )
    );
  }
}

class MovieDetail extends StatelessWidget{
  final Movie movie;
  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  movie.getPosterPath(),
                  width: screenWidth / 3,
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
                        height: 3,
                      ),
                    ),

                    Text("User score: ${movie.voteAvg}",
                      style: normalTextStyle,
                    ),
                  ],
                ),
              ))
            ],
          ),

          Text(
            "Story",
            style: subheadingStyle,
          ),

          Text(
            "${movie.overview}",
            style: normalTextStyle,
          ),
          Text(
            "Trailer:",
            style: subheadingStyle,
          )
        ],
      ),
    );
  }
}

class TrailerBody extends ResponseWidget<List<TrailerModel>> {
  TrailerBody(BuildContext context, BehaviorSubject<Result<List<TrailerModel>>> stream) : super(context, stream);

  @override
  Widget generateResponseBody(List<TrailerModel> data) {
    if (data.length > 0) {
      return trailerLayout(data);
    } else {
      return noTrailer();
    }
  }
  Widget noTrailer() {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(List<TrailerModel> data) {
    if (data.length > 1) {
      return Row(
        children: [
          trailerItem(data[0]),
          trailerItem(data[1]),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data[0]),
        ],
      );
    }
  }

  trailerItem(TrailerModel data) {
    final bloc = Provider.of<DetailMovieBloc>(context);
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: Center(
                child: IconButton(
                  icon: Icon(Icons.play_circle_filled),
                  onPressed: (){
                    if(!bloc.trailerVideoId.hasValue || data.key.toString()!=bloc.trailerVideoId.value){
                      print("data.key.toString() ${data.key.toString()}");
                      // print("bloc.trailerVideoId.value ${bloc.trailerVideoId.value}");
                      bloc.action.add(PlayTrailerAction(data.key.toString()));
                    } else {
                      // bloc.action.add(PlayTrailer(""));
                    }
                  },
                )
            ),
          ),
          Text(
            data.name.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class PlayTrailerBody extends ResponseWidget<String> {
  PlayTrailerBody(BuildContext context,BehaviorSubject<Result<String>> stream) : super(context, stream);

  @override
  Widget generateResponseBody(String data) {
    if (data.isNotEmpty) {
      return VideoTrailer(data);
    } else {
      return Container();
    }
  }
}
