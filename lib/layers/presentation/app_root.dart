import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watchdice/layers/data/repository/movie_repository.dart';
import 'package:watchdice/layers/data/source/network/omdb_api.dart';
import 'package:watchdice/layers/domain/usecase/movie_service.dart';
import 'package:watchdice/layers/presentation/shared/MovieDetailsPage.dart';
import 'package:watchdice/layers/presentation/theme.dart';

import 'package:watchdice/layers/domain/entity/movie.dart';


class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  // TODO: Dependency Injection!!
  late final MovieService service;
  var themeMode = ThemeMode.dark;
  late final Movie _movie = Movie(title: 'Loading...');
  final List<Movie> _movies =
      List<Movie>.generate(3, (_) => Movie(title: 'Loading...'));

  // Current selected index for the BottomNavigationBar
  int _selectedIndex = 0;

  // PageController for handling the page view
  late final PageController _pageController;

  Movie movie1 = new Movie(
    id: 'tt0110912',
    title: 'Django Unchained',
    year: 1994,
    released: DateTime(1994, 10, 14),
    runtime: '154 min',
    genre: [Genre.crime, Genre.drama],
    plot:
        'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire\'s world-destroying battle station, while also attempting to rescue Princess Leia from the mysterious Darth ...',
    poster: 'https://m.media-amazon.com/images/M/MV5BMjIyNTQ5NjQ1OV5BMl5BanBnXkFtZTcwODg1MDU4OA@@._V1_SX300.jpg',
    type: Type.movie,
  );

  Movie movie2 = new Movie(
    id: 'tt0110912',
    title: 'Star Wars: Episode IV - A New Hope',
    year: 1994,
    released: DateTime(1994, 10, 14),
    runtime: '154 min',
    genre: [Genre.crime, Genre.drama],
    plot:
    'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
    poster: 'https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_SX300.jpg',
    type: Type.movie,
  );

  Movie movie3 = new Movie(
    id: 'tt0110912',
    title: 'American Psycho',
    year: 1994,
    released: DateTime(1994, 10, 14),
    runtime: '154 min',
    genre: [Genre.crime, Genre.drama],
    plot:
    'A wealthy New York City investment banking executive, Patrick Bateman, hides his alternate psychopathic ego from his co-workers and friends as he delves deeper into his violent, hedonistic fantasies.',
    poster: 'https://m.media-amazon.com/images/M/MV5BZTM2ZGJmNjQtN2UyOS00NjcxLWFjMDktMDE2NzMyNTZlZTBiXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
    type: Type.movie,
  );

  @override
  void initState() {
    super.initState();

    final api = OmdbApiImpl();
    final repo = MovieRepositoryImpl(api: api);
    service = MovieServiceImpl(repository: repo);
    _fetchRandomMovie();

    // Initialize the PageController
    _pageController = PageController(initialPage: _selectedIndex);
  }

  Future<void> _fetchRandomMovie() async {
    // List<String> _names = ['Django', 'Star Wars', 'American Psycho'];

    _movies[0] = movie1;
    _movies[1] = movie2;
    _movies[2] = movie3;

    // for (int i = 0; i < 3; i++) {
      // Movie movie = await service.random(_names[i]);
      // _movies[i] = movie;
      // print('Movie $i: ${movie.getTitle()}');
      // print('Description $i: ${movie.getDescription()}');
      // print('Poster: ${movie.getPoster()}');
    // }

    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MaterialApp(
      themeMode: themeMode,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: PageView.builder(
          scrollDirection: Axis.vertical, // For vertical scrolling like Instagram Reels
          controller: _pageController,
          itemCount: _movies.length,
          itemBuilder: (context, index) {
            return MovieDetailsPage(movie: _movies[index]);
          },
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),

        // Add a BottomNavigationBar
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movie 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movie 2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movie 3',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
