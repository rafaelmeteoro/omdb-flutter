import 'package:core/domain.dart';

class FavoriteRatingEntity extends Equatable {
  const FavoriteRatingEntity({
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
