import 'package:flutter/cupertino.dart';
import 'package:netflix/base/base_bloc.dart';
import 'package:netflix/model/home_category.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/network/APIResponse.dart';

@immutable
abstract class HomeAction {}

class GetListMovieAction extends HomeAction {
  final HomeCategory category;
  GetListMovieAction(this.category);
}

class SelectMovieAction extends HomeAction {
  final Movie movie;
  final BuildContext context;
  SelectMovieAction(this.context, this.movie);
}

@immutable
abstract class HomeMessage{}

class GetListMovieMessage extends HomeMessage {
  final List<Movie> listMovie;
  GetListMovieMessage(this.listMovie);
}

class HomeErrorMessage extends HomeMessage {
  final ErrorResponse error;
  HomeErrorMessage(this.error);
}