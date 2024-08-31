part of 'MovieScrollCubit.dart';

abstract class MovieScrollState{}

class MovieScrollInitial extends MovieScrollState{}

class MovieScrollLoading extends MovieScrollState{}

class MovieScrollLoaded extends MovieScrollState{
  final List<Movie> movies;

  MovieScrollLoaded(this.movies);
}

class MovieScrollError extends MovieScrollState{
  final String message;

  MovieScrollError(this.message);
}