import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Base/BaseBloc.dart';
import 'package:netflix/config/Result.dart';
import 'package:netflix/model/home_category.dart';
import 'package:netflix/model/model.dart';
import 'package:netflix/Network/APIResponse.dart';
import 'package:netflix/Network/Service/MovieCategory/MovieRepo.dart';
import 'package:netflix/Screen/DetailMovie/DetailMovieRoute.dart';
import 'package:rxdart/rxdart.dart';

import 'HomeState.dart';

class HomeBloc extends BaseBloc {
  //Initial
  HomeMessage initialState = GetListMovieMessage([]);

  //Input
  final PublishSubject<HomeAction> action = PublishSubject<HomeAction>();
  final BehaviorSubject<List<Movie>> listMovie = BehaviorSubject<List<Movie>>.seeded([]);
  final BehaviorSubject<HomeCategory> catgorySelected = BehaviorSubject<HomeCategory>.seeded(HomeCategory.nowPlaying);
  final BehaviorSubject<int> movieSelectedIndex = BehaviorSubject<int>.seeded(0);

  HomeBloc(MovieRepo repo) {
    //Init current state
    //Listen stream
    action.listen((HomeAction event) {
      var _event = event;
      if (_event is GetListMovieAction) {
        print("GetListMovieAction");
        catgorySelected.add(_event.category);
        repo.getListMovie(_event.category)
            .doOnListen(() => {
          isLoading.add(true)
        })
            .doOnData((_) => isLoading.add(false))
       .listen((result) {
          var _result = result;
          if (_result is SuccessState && _result.value is APIListResponse<Movie>) {
            APIListResponse<Movie> response = _result.value as APIListResponse<Movie>;
            listMovie.add(response.data!);
            movieSelectedIndex.add(0);
          } else  {
            var error = result as ErrorState;
            this.error.add(error);
          }
        });
      } else if (_event is SelectMovieAction) {
        movieSelectedIndex.add(listMovie.value.indexOf(_event.movie));
        openDetailPage(_event.context, _event.movie);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    action.close();
    catgorySelected.close();
    movieSelectedIndex.close();
    listMovie.close();
  }

  openDetailPage(BuildContext context, Movie data) {
    Navigator.pushNamed(
        context,
        DetailMovieRoute.routeId,
        arguments: data
    );

    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMovieScreen(data),
      ),
    );*/
  }
}