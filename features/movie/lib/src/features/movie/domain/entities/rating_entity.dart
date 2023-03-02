import 'package:core/domain.dart';

class RatingEntity extends Equatable {
  const RatingEntity({
    required this.source,
    required this.value,
  });

  final String source;
  final String value;

  @override
  List<Object?> get props => [
        source,
        value,
      ];
}
