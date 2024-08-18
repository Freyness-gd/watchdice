import 'package:equatable/equatable.dart';

class Rating with EquatableMixin {
  Rating({
    this.source,
    this.score,
  });

  final String? source;
  final String? score;

  @override
  // TODO: implement props
  List<Object?> get props => [
        source,
        score,
      ];
}
