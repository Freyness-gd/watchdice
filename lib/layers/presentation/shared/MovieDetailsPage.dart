import 'package:flutter/material.dart';

import 'package:watchdice/layers/domain/entity/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section with the poster image
          Container(
            height: MediaQuery.of(context).size.height * 0.35, // 35% of the screen height
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.getPoster()),
                fit: BoxFit.cover, // Cover the entire container
                alignment: Alignment.topCenter, // Keep the top part of the image visible
              ),
            ),
          ),

          // Bottom section with text information
          Expanded(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.getTitle(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.getDescription(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  // Additional information like duration, ratings, genres, etc.
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
