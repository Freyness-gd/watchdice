import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchdice/layers/presentation/MovieDetails/cubit/MovieCubit.dart';
import 'package:watchdice/layers/domain/usecase/movie_service.dart';
import 'package:watchdice/layers/presentation/MovieDetails/view/MovieDetailsPage.dart';
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
  int _menuIndex = 1;

  @override
  void initState() {
    super.initState();
    service =
        MovieServiceImpl(repository: MovieRepositoryImpl(api: OmdbApiImpl()));
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubit(movieService: service),
      child: Builder(
        builder: (context) {
          // Call fetchMovies after the provider is established
          context.read<MovieCubit>().fetchMovies();

          return MaterialApp(
            themeMode: themeMode,
            theme: const CustomTheme().toThemeData(),
            darkTheme: const CustomTheme().toThemeData(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: TopBar(),
              ),
              body: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  print('Current State: $state');
                  if (state is MovieLoading) {
                    return const Center(
                      child: Text(
                        'Testing MovieLoading',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else if (state is MovieLoaded) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          'Testing MovieLoaded isEmpty',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        controller: _pageController,
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          return MovieDetailsPage(
                            movie: state.movies[index],
                          );
                        },
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    );
                  } else if (state is MovieError) {
                    return const Center(
                      child: Text(
                        'Testing MovieError',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Testing Default Empty stateeee',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
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
                selectedItemColor: const Color.fromRGBO(134, 97, 193, 1.0),
                onTap: (index) => setState(() {
                  _menuIndex = index;
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'WatchDice',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      actions: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: IconButton(
            icon: const Icon(Icons.search),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                const Color.fromRGBO(75, 82, 103, 0.16),
              ), // Background color
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                // Adjust the border radius to control the button shape
              ),
            ),
            onPressed: () {
              context.read<MovieCubit>().fetchMovies();
            },
          ),
        ),
      ],
    );
  }
}
