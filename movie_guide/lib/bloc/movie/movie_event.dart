import 'package:equatable/equatable.dart';
import 'package:movie_guide/data/model/movies_response.dart';

abstract class MovieEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchMovieEvent extends MovieEvent {
}

class LoadMoreMovieEvent extends MovieEvent {
  final MoviesResponse moviesResponse ;
  LoadMoreMovieEvent(this.moviesResponse);
}