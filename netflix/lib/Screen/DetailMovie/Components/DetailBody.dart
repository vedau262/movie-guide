import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Base/body_widget.dart';
import 'package:netflix/Base/dependency_injection.dart';
import 'package:netflix/Base/loading_dialog.dart';
import 'package:netflix/Config/ConfigBase.dart';
import 'package:netflix/Config/Result.dart';
import 'package:netflix/Model/Movie.dart';
import 'package:netflix/Model/trailer_model.dart';
import 'package:netflix/Network/APIResponse.dart';
import 'package:netflix/Screen/DetailMovie/DetailMovieBloc.dart';
import 'package:netflix/Screen/DetailMovie/VideoApp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

import '../detail_state.dart';

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

class MovieDetailPage extends State<Body>{
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = Provider.of<DetailMovieBloc>(context);
    bloc.trailer.listen((value) {
      if (value is Loading && (value as Loading).isLoading) {
        LoadingDialog.show(context);
      } else {
        LoadingDialog.hide();
      }
    });
    bloc.action.add(GetDetailAction(bloc.movie.id));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DetailMovieBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double backdropHeight = screenWidth * 9 / 16;
    Movie movie = bloc.movie;
    print("build detail");

    final VoidCallback? errorCallback;

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
                color: Colors.white,
                padding: EdgeInsets.only(top: 25),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)
            ),

            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(
                  top: backdropHeight - backdropHeight / 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: Colors.redAccent,
                                height: 3,
                              ),
                            ),

                            Text("User score: ${movie.voteAvg}",
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
                  Text(
                    "Trailer:",
                    style: TextStyle(
                      fontSize: 20,
                      height: 2,
                    ),
                  ),
                  TrailerBody(context, bloc.trailer).getBuilder(),
                  PlayTrailerBody(context, bloc.trailerVideoId).getBuilder(),
                ],
              ),
            )
          ],
        )
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
  PlayTrailerBody(BuildContext context,
      BehaviorSubject<Result<String>> stream)
      : super(context, stream);


  @override
  Widget generateResponseBody(String data) {
    if (data.isNotEmpty) {
      return VideoApp(data);
    } else {
      return Container();
    }
  }
}
class LikeButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // We have access to it anywhere in the app with this simple call
    var appInfo = Provider.of<AppInfo>(context);
    return Container(
      child: Text(appInfo.welcomeMessage),
    );
  }
}