import 'package:flutter/material.dart';
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
  late final MovieService service;
  var themeMode = ThemeMode.dark;
  final List<Movie> _movies = List<Movie>.generate(3, (_) => Movie(title: 'Loading...'));
  int _selectedIndex = 0;
  late final PageController _pageController;
  int _menuIndex = 0;

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

  @override
  void initState() {
    super.initState();
    service = MovieServiceImpl(repository: MovieRepositoryImpl(api: OmdbApiImpl()));
    _pageController = PageController(initialPage: _selectedIndex);
    _fetchRandomMovie();
  }

  Future<void> _fetchRandomMovie() async {
    _movies[0] = movie1;
    _movies[1] = movie2;
    _movies[2] = movie3;
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _menuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: themeMode,
      theme: const CustomTheme().toThemeData(),
      darkTheme: const CustomTheme().toThemeDataDark(),
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: PageView.builder(
          scrollDirection: Axis.vertical,
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
        // The BottomNavigationBar is now synced with the PageView
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _menuIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
