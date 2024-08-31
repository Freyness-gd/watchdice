import 'package:bloc/bloc.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';

part 'FavoritesState.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final List<Movie> _favoriteMovies = [];

  void addMovieToFavorites(Movie movie) {
    if (!_favoriteMovies.contains(movie)) {
      _favoriteMovies.add(movie);
      emit(FavoritesUpdated(List.unmodifiable(_favoriteMovies)));
    }
  }

  void removeMovieFromFavorites(Movie movie) {
    if (_favoriteMovies.contains(movie)) {
      _favoriteMovies.remove(movie);
      emit(FavoritesUpdated(List.unmodifiable(_favoriteMovies)));
    }
  }

  List<Movie> get favoriteMovies => List.unmodifiable(_favoriteMovies);

  bool isFavorite(Movie movie) => _favoriteMovies.contains(movie);
}
