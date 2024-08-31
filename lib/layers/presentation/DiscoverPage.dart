// DiscoverPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchdice/layers/presentation/MovieDetails/cubit/MovieCubit.dart';
import 'package:watchdice/layers/presentation/MovieDetails/view/MovieDetailsPage.dart';
import 'package:watchdice/layers/presentation/MovieScroll/cubit/MovieScrollCubit.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieScrollCubit, MovieScrollState>(
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
              controller: PageController(), // You can pass in _pageController if needed
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return BlocProvider(
                  create: (context) => MovieCubit(movie: state.movies[index]),
                  child: const MovieDetailsPage(),
                );
              },
              onPageChanged: (index) {
                // If you need to handle page changes, pass in a callback
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
    );
  }
}
