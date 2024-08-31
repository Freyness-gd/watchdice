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
            margin: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(movie.getPoster()),
                fit: BoxFit.fill,
                // Ensures the image covers the container without overflowing
                alignment: Alignment
                    .topCenter, // Ensures the top part of the image is visible
              ),
            ),
          ),
          // Bottom section with text information
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      movie.getTitle(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, // Handle long titles
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 8),
                  // Additional information like duration, ratings, genres, etc.
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
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
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
