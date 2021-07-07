import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_guide/data/model/MoviesResponse.dart';
import 'package:movie_guide/data/model/movie.dart';



abstract class MoviesState extends Equatable {

}

class MoviesInitialState extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoadingState extends MoviesState {
  @override
  List<Object> get props => [];
}

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

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Movie>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Movie> posts;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus? status,
    List<Movie>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}

