import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watchdice/layers/data/repository/movie_repository.dart';
import 'package:watchdice/layers/data/source/network/omdb_api.dart';
import 'package:watchdice/layers/domain/usecase/movie_service.dart';
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
  late Movie _movie = Movie(title: 'Loading...');

  @override
  void initState() {
    super.initState();

    final api = OmdbApiImpl();
    final repo = MovieRepositoryImpl(api: api);
    service = MovieServiceImpl(repository: repo);
    _fetchRandomMovie();
  }

  Future<void> _fetchRandomMovie() async {
    _movie = await service.random('Django');
    print("Hello");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MaterialApp(
      themeMode: themeMode,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final tt = Theme.of(context).textTheme;
          final cs = Theme.of(context).colorScheme;

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Transform.translate(
                offset: const Offset(10, 0),
                child: Text(
                  'Hello this is a movie: ${_movie.getTitle()}',
                  style: tt.headlineLarge!.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
            ),
          );
        },
      ),
    );
  }
}
