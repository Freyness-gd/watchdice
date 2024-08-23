import 'package:watchdice/layers/data/repository/movie_repository.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';

abstract class MovieService {
  Future<Movie> random(String word);
}

class MovieServiceImpl implements MovieService {
  final MovieRepository _repository;

  // TODO: Dependency Injection!!
  MovieServiceImpl({
    required MovieRepository repository,
  }) : _repository = repository;

  @override
  Future<Movie> random(String word) {
    return _repository.getRandomMovie(word: word);
  }
}
