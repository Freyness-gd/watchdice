import 'package:equatable/equatable.dart';

class Rating with EquatableMixin {
  Rating({
    this.source,
    this.value,
  });

  final String? source;
  final String? value;

  @override
  // TODO: implement props
  List<Object?> get props => [
        source,
        value,
      ];
}
