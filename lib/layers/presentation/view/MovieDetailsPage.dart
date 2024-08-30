import 'package:flutter/material.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({required this.movie, Key? key}) : super(key: key);

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
                fit: BoxFit.cover, // Ensures the image covers the container without overflowing
                alignment: Alignment.topCenter, // Ensures the top part of the image is visible
              ),
            ),
          ),
          // Bottom section with text information
          Expanded(
            child: SingleChildScrollView(
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // Handle long titles
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.getDescription(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify, // Justify text for better readability
                  ),
                  // Additional information like duration, ratings, genres, etc.
                  const SizedBox(height: 16),
                  Text(
                    'Year: ${movie.getYear()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Runtime: ${movie.getRuntime()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Genres: ${movie.getGenres()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
