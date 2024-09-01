import 'package:bloc/bloc.dart';

import 'package:watchdice/layers/domain/usecase/movie_service.dart';

import 'package:watchdice/layers/domain/entity/movie.dart';

part 'MovieScrollState.dart';

class MovieScrollCubit extends Cubit<MovieScrollState> {
  final MovieService movieService;

  MovieScrollCubit({required this.movieService}) : super(MovieScrollInitial());

  void fetchMovies() async {
    try {
      print('fetchMovies called');
      emit(MovieScrollLoading());
      final movies = movieService.getMovies();
      emit(MovieScrollLoaded(movies));
    } catch (e) {
      emit(MovieScrollError('Failed to load movies'));
    }
  }

  void searchMovies(String query) async {
    try {
      print('searchMovies called');
      emit(MovieScrollLoading());
      final movies = await movieService.search(query);
      emit(MovieScrollLoaded(movies));
    } catch (e) {
      emit(MovieScrollError('Search faile for $query'));
    }
  }

}