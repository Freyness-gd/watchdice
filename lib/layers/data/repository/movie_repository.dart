import 'package:watchdice/layers/data/source/network/omdb_api.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';

abstract class MovieRepository {
  Future<Movie> getRandomMovie({String word = 'star wars'});
}

class MovieRepositoryImpl implements MovieRepository {
  final OmdbApi _api;

  MovieRepositoryImpl({
    required OmdbApi api,
  }) : _api = api;

  @override
  Future<Movie> getRandomMovie({String word = 'star wars'}) async {
    final fetchedMovie = await _api.loadRandom(word);
    return fetchedMovie;
  }



}
