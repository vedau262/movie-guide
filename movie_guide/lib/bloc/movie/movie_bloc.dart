import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_guide/bloc/movie/movie_event.dart';
import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'package:movie_guide/data/model/movies_response.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:movie_guide/data/repository/movies_repository.dart';
import 'package:movie_guide/strings/strings.dart';

class MovieBloc extends Bloc<MovieEvent, PostState> {

  final MoviesRepository repository;
  MovieBloc({required this.repository}) : super(LoadMovieState(List.empty()));

  List<MoviesResponse> responseList = List.generate(AppStrings.titleList.length, (index)
  => MoviesResponse(
    title: AppStrings.titleList[index],
    link: AppStrings.linkList[index],
  ));

  @override
  Stream<PostState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieEvent) {
      yield LoadMovieState(List.empty());
      try {
        List<MoviesResponse> allInput = [];
        for(int i=0; i< responseList.length; i++){
          MoviesResponse element = responseList[i];
          MoviesResponse popularResponse = await repository.getMovies(element.title.toString(), element.link.toString(), 1);
          allInput.add(popularResponse);
        }

        yield LoadMovieState(allInput);
      } catch (e) {
        yield LoadMoviesErrorState(message: e.toString());
      }
    } else if(event is LoadMoreMovieEvent){
        MoviesResponse current  = event.moviesResponse;
        yield UpdateMovieState(current);

        try{
          print("LoadMoreMovieEvent current.length ${current.getResult().length}");
          print("LoadMoreMovieEvent current.page ${current.page}");
          MoviesResponse popularResponse = await repository.getMovies(event.moviesResponse.title.toString(), event.moviesResponse.link.toString(), event.moviesResponse.getPage());
          print("LoadMoreMovieEvent popularResponse.page ${popularResponse.getPage()}");
          current.results!.addAll(popularResponse.getResult());
          current.page = popularResponse.page;
          print("LoadMoreMovieEvent current.length ${current.getResult().length}");
          yield UpdateMovieState(current);
        } catch(e){
          yield LoadMoviesErrorState(message: e.toString());
        }

    }
  }

}