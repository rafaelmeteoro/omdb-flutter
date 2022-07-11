import 'package:core/domain.dart';

class RatingEntity extends Equatable {
  final String source;
  final String value;

  const RatingEntity({
    required this.source,
    required this.value,
  });

  @override
  List<Object?> get props => [
        source,
        value,
      ];
}
