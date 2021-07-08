import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_guide/data/model/movies_response.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/strings/strings.dart';


enum LoadingStatus { initial, success, failure }

abstract class LoadingState extends Equatable {

}

class MoviesLoadingState extends LoadingState {
  final String category;
  MoviesLoadingState(this.category);

  @override
  List<Object> get props => [];
}

class LoadMovieState extends LoadingState{

  final List<MoviesResponse> responseList;
  LoadMovieState(this.responseList);

  @override
  List<Object> get props => [responseList];
}

class UpdateMovieState extends LoadingState{

  final MoviesResponse response;
  UpdateMovieState(this.response);

  @override
  List<Object> get props => [response];
}

class LoadMoviesErrorState extends LoadingState {

  final String message;

  LoadMoviesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

