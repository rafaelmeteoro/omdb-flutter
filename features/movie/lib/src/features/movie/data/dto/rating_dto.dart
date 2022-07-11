import 'package:app_core/app_core.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';

class RatingDto extends RatingEntity {
  const RatingDto({
    required String source,
    required String value,
  }) : super(
          source: source,
          value: value,
        );

  factory RatingDto.fromJson(JsonFormat json) {
    return RatingDto(
      source: json['Source'],
      value: json['Value'],
    );
  }
}
