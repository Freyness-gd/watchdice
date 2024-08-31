import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchdice/layers/presentation/Favorites/cubit/FavoritesCubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<FavoritesCubit>().loadFavorites();

    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 15,
        right: 15,
        bottom: 30,
      ),
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          print('FavoritesPage: state=$state');
          if (state is FavoritesLoaded) {
            return Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: state.favoritesMovies.map((movie) {
                return Chip(
                  label: Text(movie.getTitle()), // Assuming getTitle() is a method in your Movie class
                );
              }).toList(),
            );
          } else if (state is FavoritesEmpty) {
            return const Center(child: Text('No favorites yet.'));
          } else if (state is FavoritesError) {
            return Center(child: Text('Failed to load favorites: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}