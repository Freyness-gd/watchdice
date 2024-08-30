import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchdice/layers/presentation/cubit/MovieCubit.dart';
import 'package:watchdice/layers/domain/usecase/movie_service.dart';
import 'package:watchdice/layers/presentation/shared/MovieDetailsPage.dart';
import 'package:watchdice/layers/presentation/theme.dart';
import 'package:watchdice/layers/data/repository/movie_repository.dart';
import 'package:watchdice/layers/data/source/network/omdb_api.dart';

class CubitApp extends StatefulWidget {
  const CubitApp({super.key});

  @override
  State<CubitApp> createState() => _CubitAppState();
}

class _CubitAppState extends State<CubitApp> {
  late final MovieService service;
  var themeMode = ThemeMode.dark;
  int _selectedIndex = 0;
  late final PageController _pageController;
  int _menuIndex = 0;

  @override
  void initState() {
    super.initState();
    service = MovieServiceImpl(repository: MovieRepositoryImpl(api: OmdbApiImpl()));
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(movieService: service),
      child: MaterialApp(
        themeMode: themeMode,
        theme: const CustomTheme().toThemeData(),
        darkTheme: const CustomTheme().toThemeDataDark(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MovieDetailsPage(movie: state.movies[index]);
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              } else if (state is MovieError) {
                return const Center(child: Text('Failed to load movies'));
              }
              return Container(); // Default empty state
            },
          ),
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
            onTap: (index) => setState(() {
              _menuIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}
