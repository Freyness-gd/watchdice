import 'dart:convert';

import 'package:watchdice/layers/domain/entity/rating.dart';

class RatingDto extends Rating {
  RatingDto({
    super.source,
    super.value,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory RatingDto.fromRawJson(String str) =>
      RatingDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------
  factory RatingDto.fromMap(Map<String, dynamic> json) => RatingDto(
        source: json['source'],
        value: json['value'],
      );

  Map<String, dynamic> toMap() => {
        'source': source,
        'value': value,
      };
}