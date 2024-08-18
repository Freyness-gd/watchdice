import 'package:equatable/equatable.dart';
import 'package:watchdice/layers/domain/entity/rating.dart';

enum Genre {
  action,
  adventure,
  animation,
  biography,
  comedy,
  crime,
  documentary,
  drama,
  family,
  fantasy,
  filmnoir,
  history,
  horror,
  music,
  musical,
  mystery,
  romance,
  scifi,
  short,
  sport,
  superhero,
  thriller,
  war,
  western,
}

enum Type{
  movie,
  series,
  episode,
}

class Movie with EquatableMixin {
  Movie({
    this.id,
    this.title,
    this.year,
    required this.released,
    required this.runtime,
    this.genre,
    required this.plot,
    required this.poster,
    this.rating,
    this.type,
  });

  final int? id; // imdbID
  final String? title;
  final int? year;
  final DateTime released;
  final Duration runtime;
  final List<Genre>? genre;
  final String plot;
  final String poster;
  final List<Rating>? rating;
  final Type? type;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
