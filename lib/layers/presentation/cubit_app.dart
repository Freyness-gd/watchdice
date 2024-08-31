import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchdice/layers/domain/usecase/movie_service.dart';
import 'package:watchdice/layers/presentation/MovieScroll/cubit/MovieScrollCubit.dart';
import 'package:watchdice/layers/presentation/Favorites/view/FavoritesPage.dart';
import 'package:watchdice/layers/presentation/pages/ProfilePage.dart';
import 'package:watchdice/layers/presentation/theme.dart';
import 'package:watchdice/layers/data/repository/movie_repository.dart';
import 'package:watchdice/layers/data/source/network/omdb_api.dart';

import 'package:watchdice/layers/presentation/Favorites/cubit/FavoritesCubit.dart';

import 'package:watchdice/layers/presentation/pages/DiscoverPage.dart';

class CubitApp extends StatefulWidget {
  const CubitApp({super.key});

  @override
  State<CubitApp> createState() => _CubitAppState();
}

class _CubitAppState extends State<CubitApp> {
  late final MovieService service;
  var themeMode = ThemeMode.dark;
  late final PageController _pageController;
  int _menuIndex = 1;

  @override
  void initState() {
    super.initState();
    service =
        MovieServiceImpl(repository: MovieRepositoryImpl(api: OmdbApiImpl()));
    _pageController = PageController();
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
              body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: const Offset(0.0, 2.0),
                        end: Offset.zero,
                      ),
                    ),
                    child: child,
                  );
                },
                child: _selectedPage(),
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
                unselectedItemColor: const Color.fromRGBO(75, 82, 103, 0.75),
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

  Widget _selectedPage() {
    switch (_menuIndex) {
      case 0:
        return const FavoritesPage();
      case 1:
        return const DiscoverPage();
      case 2:
        return const ProfilePage();
      default:
        return const DiscoverPage();
    }
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
            style: ButtonStyle(// Background color
              foregroundColor: WidgetStateProperty.all<Color>(
                const Color.fromRGBO(134, 97, 193, 1),
              ), // Icon color
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
