import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';
import 'package:watchdice/layers/presentation/MovieDetails/cubit/MovieCubit.dart';

import 'package:watchdice/layers/presentation/Favorites/cubit/FavoritesCubit.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieCubit = context.read<MovieCubit>();
    final movie = movieCubit.state is MovieLoaded
        ? (movieCubit.state as MovieLoaded).movie
        : null;

    if (movie == null) return const Center(child: Text('No movie found'));

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return MovieCard(movie: movie);
      },
    );
  }
}

class MovieCard extends StatefulWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isDetails = false;

  Widget _turnCard(Movie movie) {
    print('_turnCard: $_isDetails');
    return _isDetails
        ? MovieDetailsCard(movie: movie)
        : MoviePoster(movie: movie);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isDetails = !_isDetails;
            });
          },
          borderRadius: BorderRadius.circular(25),
          splashFactory: InkRipple.splashFactory,
          splashColor: const Color.fromRGBO(134, 97, 193, 0.25),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final rotate = Tween(begin: pi, end: 0.0).animate(animation);

                  return AnimatedBuilder(
                    animation: rotate,
                    child: child,
                    builder: (context, child) {
                      final isUnder = (ValueKey(_isDetails) != child!.key);
                      var tilt = (animation.value - 0.5).abs() - 0.5;
                      tilt *= isUnder ? -0.003 : 0.003;
                      final value =
                          isUnder ? min(rotate.value, pi / 2) : rotate.value;
                      return Transform(
                        transform: Matrix4.rotationY(value)
                          ..setEntry(3, 0, tilt),
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                  );
                },
                child: _turnCard(widget.movie),
              ),
              Expanded(
                child:
                    _isDetails ? Container() : MovieTitle(movie: widget.movie),
              ),
            ],
          ),
        ),
        const FavoriteIcon(),
      ],
    );
  }
}

class MovieTitle extends StatelessWidget {
  const MovieTitle({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              movie.getTitle(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 7,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: NetworkImage(movie.getPoster()),
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class MovieDetailsCard extends StatelessWidget {
  const MovieDetailsCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 7,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child: Information(movie: movie)),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final movieCubit = context.read<MovieCubit>();
    final movie = (movieCubit.state as MovieLoaded).movie;

    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        right: 30,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final isFavorite = context.read<FavoritesCubit>().isFavorite(movie);
            double opacity = isFavorite ? 1.0 : 0.5;

            return Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(190, 151, 198, opacity),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                color: isFavorite
                    ? const Color.fromRGBO(134, 97, 193, 1)
                    : const Color.fromRGBO(46, 41, 78, 1),
                onPressed: () {
                  final favoritesCubit = context.read<FavoritesCubit>();
                  if (isFavorite) {
                    favoritesCubit.removeMovieFromFavorites(movie);
                  } else {
                    favoritesCubit.addMovieToFavorites(movie);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Information extends StatelessWidget {
  const Information({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            movie.getTitle(),
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.getDescription(),
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 20,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          Text(
            'Runtime: ${movie.getRuntime()}',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Year: ${movie.getYear()}',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Genre: ${movie.getGenres()}',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Rating: ${movie.getRating()}',
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
