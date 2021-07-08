import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_guide/data/model/movies_response.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/strings/strings.dart';



abstract class MoviesState extends Equatable {

}

class MoviesInitialState extends MoviesState {
  @override
  List<Object> get props => [];
}

/*class MoviesLoadingState extends MoviesState {
  @override
  List<Object> get props => [];
}*/

class MoviesLoadedState extends MoviesState {

  MoviesResponse popularResponse, upcomingResponse;

  MoviesLoadedState({
      required this.popularResponse,
      required this.upcomingResponse
  });

  @override
  List<Object> get props => [popularResponse, upcomingResponse];
}

class MoviesErrorState extends MoviesState {

  String message;

  MoviesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}



enum PostStatus { initial, success, failure }

abstract class PostState extends Equatable {

}

class MoviesLoadingState extends PostState {
  String category;
  MoviesLoadingState(this.category);
  @override
  List<Object> get props => [];
}

class LoadMovieState extends PostState{

  List<MoviesResponse> responseList;

  List<MoviesResponse> result = List.empty();
  LoadMovieState(this.responseList);

  void addResult(MoviesResponse moviesResponse){
    result.add(moviesResponse);
  }

  @override
  List<Object> get props => [responseList];
}

class UpdateMovieState extends PostState{

  MoviesResponse response;
  UpdateMovieState(this.response);

  void updateResult(MoviesResponse moviesResponse){
    response = moviesResponse;
  }

  @override
  List<Object> get props => [response];
}

class LoadMoviesErrorState extends PostState {

  String message;

  LoadMoviesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

