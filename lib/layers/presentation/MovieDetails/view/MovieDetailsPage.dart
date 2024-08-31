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
    final movie = movieCubit.state is MovieLoaded ? (movieCubit.state as MovieLoaded).movie : null;

    if (movie == null) return const Center(child: Text('No movie found'));

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFavorite = context.read<FavoritesCubit>().isFavorite(movie);

        return InkWell(
          onTap: () {
            print('Tap Tap Tap');
          },
          splashFactory: InkRipple.splashFactory,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 18),
              MoviePoster(movie: movie),
              Expanded(child: MovieTitle(movie: movie)),
              IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  final favoritesCubit = context.read<FavoritesCubit>();
                  if (isFavorite) {
                    favoritesCubit.removeMovieFromFavorites(movie);
                  } else {
                    favoritesCubit.addMovieToFavorites(movie);
                  }
                },
              ),
            ],
          ),
        );
      },
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

class Information extends StatelessWidget {
  const Information({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            movie.getDescription().length > 200
                ? '${movie.getDescription().substring(0, 200)}...'
                : movie.getDescription(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
          Column(
            children: [
              Text(
                'Year: ${movie.getYear()}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Runtime: ${movie.getRuntime()}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Genres: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    movie.getGenres(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    'Type: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    movie.getType(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
