import 'dart:convert';

import 'package:watchdice/layers/domain/entity/movie.dart';
import 'package:watchdice/layers/domain/entity/rating.dart';
import 'package:intl/intl.dart';

Type _stringToType(String? type) {
  switch (type?.toLowerCase()) {
    case 'movie':
      return Type.movie;
    case 'series':
      return Type.series;
    case 'episode':
      return Type.episode;
    default:
      return Type.other;
  }
}

List<Rating> _stringToRatingList(List<dynamic>? ratings) {
  print('Movie ratings: $ratings');

  return [];
}

List<Genre> _stringToGenreList(String list) {

  List<String> genre = list.toLowerCase().replaceAll('-', '').split(',').toList();

  return [];
}

class MovieDto extends Movie {
  MovieDto({
    super.id,
    super.title,
    super.year,
    super.released,
    super.runtime,
    super.genre,
    super.plot,
    super.poster,
    super.rating,
    super.type,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory MovieDto.fromRawJson(String str) =>
      MovieDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------
  factory MovieDto.fromMap(Map<String, dynamic> json) => MovieDto(
        id: json['imdbID'],
        title: json['Title'],
        year: int.parse(json['Year']),
        released: DateFormat("dd MMM yyyy").parse(json['Released']),
        runtime: json['Runtime'],
        genre: _stringToGenreList(json['Genre'].toString()),
        plot: json['Plot'],
        poster: json['Poster'] == 'N/A' ? 'https://via.assets.so/img.jpg?w=500&h=1000&tc=#8661C1&bg=#cecece&t=Placeholder' : json['Poster'],
        rating: _stringToRatingList(json['Ratings']),
        type: _stringToType(json['Type']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'year': year,
        'released': released?.toIso8601String(),
        'runtime': runtime,
        'genre': genre != null
            ? List<dynamic>.from(genre!.map((dynamic x) => x))
            : Genre.other,
        'plot': plot,
        'poster': poster,
        'rating': rating?.asMap(),
        'type': type,
      };
}
