// movie_state.dart
part of 'MovieCubit.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final Movie movie;

  MovieLoaded(this.movie);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
