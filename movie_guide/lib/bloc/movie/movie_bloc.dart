import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_guide/bloc/movie/movie_event.dart';
import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'package:movie_guide/data/model/MoviesResponse.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/data/repository/movies_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MoviesState> {

  final MoviesRepository repository;
  MovieBloc({required this.repository}) : super(MoviesInitialState());


  @override
  MoviesState get initialState => MoviesInitialState();
  String name = 'aa';
  String age = '6';

  @override
  Stream<MoviesState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieEvent) {
      yield MoviesLoadingState();
      try {
        MoviesResponse popularResponse = await repository.getPopularMovies();
        MoviesResponse upcomingResponse = await repository.getUpcomingMovies();
        yield MoviesLoadedState(popularResponse: popularResponse, upcomingResponse: upcomingResponse);
      } catch (e) {
        yield MoviesErrorState(message: e.toString());
      }
    }
  }

}