import 'package:equatable/equatable.dart';

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

class Movie with EquatableMixin {
  Movie({

});

  final int? id; // imdbID
  final String? title;
  final int? year;
  final DateTime released;
  final Duration runtime;
  final List<Genre>? genre;
  final String plot;
  final String poster;
  

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}