part of 'FavoritesCubit.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<Movie> favorites;

  FavoritesUpdated(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}

class FavoritesEmpty extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Movie> favoritesMovies;

  FavoritesLoaded({required this.favoritesMovies});
}