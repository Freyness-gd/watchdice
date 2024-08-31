import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchdice/layers/presentation/MovieDetails/cubit/MovieCubit.dart';
import 'package:watchdice/layers/domain/usecase/movie_service.dart';
import 'package:watchdice/layers/presentation/MovieDetails/view/MovieDetailsPage.dart';
import 'package:watchdice/layers/presentation/MovieScroll/cubit/MovieScrollCubit.dart';
import 'package:watchdice/layers/presentation/theme.dart';
import 'package:watchdice/layers/data/repository/movie_repository.dart';
import 'package:watchdice/layers/data/source/network/omdb_api.dart';

import 'package:watchdice/layers/presentation/Favorites/cubit/FavoritesCubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieScrollCubit>(
          create: (context) {
            final cubit = MovieScrollCubit(movieService: service);
            cubit.fetchMovies();
            return cubit;
          },
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
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
              body: BlocBuilder<MovieScrollCubit, MovieScrollState>(
                builder: (context, state) {
                  print('Current State: $state');
                  if (state is MovieScrollLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieScrollLoaded) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          'No movies available',
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
                          return BlocProvider(
                            create: (context) =>
                                MovieCubit(movie: state.movies[index]),
                            child: const MovieDetailsPage(),
                          );
                        },
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    );
                  } else if (state is MovieScrollError) {
                    return const Center(
                      child: Text(
                        'Error loading movies',
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  } else {
                    return Container();
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
              // context.read<MovieScrollCubit>().fetchMovies();
            },
          ),
        ),
      ],
    );
  }
}
