import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_guide/bloc/movie/movie_event.dart';
import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'package:movie_guide/data/model/movies_response.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/data/repository/movies_repository.dart';
import 'package:movie_guide/strings/strings.dart';

class MovieBloc extends Bloc<MovieEvent, LoadingState> {

  final MoviesRepository repository;
  MovieBloc({required this.repository}) : super(LoadMovieState(List.empty()));

  final List<MoviesResponse> responseList = List.generate(AppStrings.titleList.length, (index)
  => MoviesResponse(
    title: AppStrings.titleList[index],
    link: AppStrings.linkList[index],
  ));

  @override
  Stream<LoadingState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieEvent) {
      yield LoadMovieState(List.empty());
      try {
        List<MoviesResponse> output = [];
        for(int i=0; i< responseList.length; i++){
          MoviesResponse element = responseList[i];
          MoviesResponse response = await repository.getMovies(element.title.toString(), element.link.toString(), 1);
          output.add(response);
        }

        yield LoadMovieState(output);
      } catch (e) {
        yield LoadMoviesErrorState(message: e.toString());
      }
    } else if(event is LoadMoreMovieEvent){
        yield MoviesLoadingState(event.moviesResponse.title.toString());
        MoviesResponse current  = event.moviesResponse;

        try{
          // print("LoadMoreMovieEvent current.length ${current.getResult().length}");
          print("LoadMoreMovieEvent current.page ${current.page}");
          MoviesResponse response = await repository.getMovies(event.moviesResponse.title.toString(), event.moviesResponse.link.toString(), event.moviesResponse.getPage());
          print("LoadMoreMovieEvent response.page ${response.getPage()}");
          current.results!.addAll(response.getResult());
          current.page = response.page;
          // print("LoadMoreMovieEvent current.length ${current.getResult().length}");
          yield UpdateMovieState(current);
        } catch(e){
          yield LoadMoviesErrorState(message: e.toString());
        }

    }
  }

}