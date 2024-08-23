import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:watchdice/layers/data/dto/movie_dto.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';

abstract class OmdbApi {
  Future<MovieDto> loadRandom(String word);
}

class OmdbApiImpl implements OmdbApi {
  final dio = Dio();
  final _API_URL = dotenv.env['API_URL'] ?? '';
  final _API_KEY = dotenv.env['API_KEY'] ?? '';

  @override
  Future<MovieDto> loadRandom(String word) async {
    try {
      final Response<Map<String, dynamic>> response =
          await dio.get('$_API_URL/?apikey=$_API_KEY&s=$word&type=movie');

      final imdbId = response.data!['Search'][0]['imdbID'];

      final Response<Map<String, dynamic>> responseMov =
          await dio.get('$_API_URL/?apikey=$_API_KEY&i=$imdbId');

      try {
        final movieDto = MovieDto.fromMap(responseMov.data!);
        return movieDto;
      } catch (e) {
        print('Unhandled Exception: {$e}');

      }

      return MovieDto();

    } on DioException catch (e) {
      print('Unhandled DioException: {$e}');
    }

    // return empty MovieDto if no result is found
    return Future.value(MovieDto());
  }
}
