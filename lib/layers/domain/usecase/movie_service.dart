import 'package:watchdice/layers/data/repository/movie_repository.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';

abstract class MovieService {
  Future<Movie> random(String word);

  List<Movie> getMovies();

  Future<List<Movie>> search(String query);
}

class MovieServiceImpl implements MovieService {
  final MovieRepository _repository;
  late final List<Movie> _movies = List<Movie>.generate(3, (_) => Movie(title: 'Loading...'));

  // Define your movies manually
  final Movie movie1 = Movie(
    id: 'tt0110912',
    title: '300',
    year: 1994,
    released: DateTime(2011, 10, 14),
    runtime: '45 min',
    genre: [Genre.crime, Genre.drama],
    plot: 'In the ancient battle of Thermopylae, King Leonidas and 300 Spartans fight against Xerxes and his massive Persian army.',
    poster: 'https://m.media-amazon.com/images/M/MV5BMjc4OTc0ODgwNV5BMl5BanBnXkFtZTcwNjM1ODE0MQ@@._V1_SX300.jpg',
    type: Type.movie,
  );

  final Movie movie2 = Movie(
    id: 'tt0110912',
    title: 'Star Wars: Episode IV - A New Hope',
    year: 1994,
    released: DateTime(1994, 10, 14),
    runtime: '154 min',
    genre: [Genre.crime, Genre.drama],
    plot: 'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire\'s world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth ...',
    poster: 'https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_SX300.jpg',
    type: Type.movie,
  );

  final Movie movie3 = Movie(
    id: 'tt0110912',
    title: 'American Psycho',
    year: 1994,
    released: DateTime(1994, 10, 14),
    runtime: '154 min',
    genre: [Genre.crime, Genre.drama],
    plot: 'A wealthy New York City investment banking executive, Patrick Bateman, hides his alternate psychopathic ego from his co-workers and friends as he delves deeper into his violent, hedonistic fantasies.',
    poster: 'https://m.media-amazon.com/images/M/MV5BZTM2ZGJmNjQtN2UyOS00NjcxLWFjMDktMDE2NzMyNTZlZTBiXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    type: Type.movie,
  );

  // TODO: Dependency Injection!!
  MovieServiceImpl({
    required MovieRepository repository,
  }) : _repository = repository {
    initializeMovies();
  }

  void initializeMovies() {
    _movies.removeAt(0);
    _movies.insert(0, movie1);
    _movies.removeAt(1);
    _movies.insert(1, movie2);
    _movies.removeAt(2);
    _movies.insert(2, movie3);
  }

  @override
  Future<Movie> random(String word) {
    return _repository.getRandomMovie(word: word);
  }

  @override
  List<Movie> getMovies() {
    return _movies;
  }

  @override
  Future<List<Movie>> search(String query) {
    return _repository.searchMovies(query);
  }
}
