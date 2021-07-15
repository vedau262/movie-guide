
import 'package:flutter/material.dart';
import 'package:netflix/base/base_bloc.dart';
import 'package:netflix/config/result.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/network/APIResponse.dart';
import 'package:netflix/network/service/movie_category/movie_repo.dart';
import 'package:netflix/screen/detail_movie/detail_state.dart';
import 'package:netflix/model/trailer.dart';
import 'package:rxdart/rxdart.dart';

class DetailMovieBloc extends BaseBloc {
  final Movie movie;
  MovieRepo movieRepo = MovieRepo();

  //Input
  final PublishSubject<DetailAction> action = PublishSubject<DetailAction>();
  final BehaviorSubject<Result<List<TrailerModel>>> trailer = BehaviorSubject<Result<List<TrailerModel>>>();
  final BehaviorSubject<Result<String>> trailerVideoId = BehaviorSubject<Result<String>>();

  @override
  void dispose(){
    super.dispose();
    action.close();
    trailer.close();
  }

  DetailMovieBloc(this.movie){
    action.listen((DetailAction action) {
      if(action is GetDetailAction){
        movieRepo.getListTrailerMovie(action.movieId)
            .doOnListen(() => {
              isLoading.add(true),
              trailer.add(Loading(true))
            })
          .delay(Duration(milliseconds: 200))
          .doOnData((result) => {
            isLoading.add(false),
            trailer.add(Loading(false))
          } )

          .listen((result) {
            print("listen((result) ${result.toString()}");
            var _result = result;
            if (_result is SuccessState && _result.value is APIListTrailerResponse<TrailerModel>) {
              APIListTrailerResponse<TrailerModel> response = _result.value as APIListTrailerResponse<TrailerModel>;
              trailer.add(Result.success(response.data ?? []));
            } else  {
              var error = result as ErrorState;
              print("listen((result) ${error.error}");
              this.error.add(error);
              this.trailer.add(Result.error(error.error));
            }}
        )
        ;
        // .listen((event) {_trailer.add(event.) });
      } else if(action is PlayTrailerAction){
        trailerVideoId.add(Result.success(action.videoLink));
      } else if(action is ShowSnackBarAction){
        showSnackBar(action.context, action.message);
        _showMyDialog(action.context, action.message);
    }

    });
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message,
            style: TextStyle(
              color: Colors.red
            ),
          ),
        duration: Duration(seconds: 2),
    ));

  }

  Future<void> _showMyDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}