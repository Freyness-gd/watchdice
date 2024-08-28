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
  other,
}

enum Type {
  movie,
  series,
  episode,
  other,
}

class Movie with EquatableMixin {
  Movie({
    this.id,
    this.title,
    this.year,
    this.released,
    this.runtime,
    this.genre,
    this.plot,
    this.poster,
    this.rating,
    this.type,
  });

  final String? id; // imdbID
  final String? title;
  final int? year;
  final DateTime? released;
  final String? runtime;
  final List<Genre>? genre;
  final String? plot;
  final String? poster;
  final List<Rating>? rating;
  final Type? type;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  String getTitle() {
    return title ?? 'No Title';
  }

  String getPoster() {
    return poster ?? 'No Poster';
  }

  String getDescription() {
    return plot ?? 'No Description';
  }

  String getYear() {
    return year.toString();
  }

  String getRuntime() {
    return runtime ?? 'No Runtime';
  }

  String getGenres() {
    return genre?.map((e) => e.toString().split('.').last).join(', ') ?? 'No Genres';
  }

  String getRating() {
    return rating?.map((e) => e.value).join(', ') ?? 'No Rating';
  }

  String getType() {
    return type.toString().split('.').last;
  }


}
