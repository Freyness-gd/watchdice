import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';
import 'package:watchdice/layers/domain/usecase/movie_service.dart';


part 'MovieState.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieService movieService;

  MovieCubit({required this.movieService}) : super(MovieInitial());

  void fetchMovies() async {
    try {
      print('fetchMovies called');
      emit(MovieLoading());
      final movies = movieService.getMovies();
      print('Movies fetched: ${movies.length}');
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to load movies'));
    }
  }
}
