import 'package:app_core/app_core.dart';

import '../../domain/entities/favorite_rating_entity.dart';

class FavoriteRatingDto extends FavoriteRatingEntity {
  const FavoriteRatingDto({
    required super.source,
    required super.value,
  });

  factory FavoriteRatingDto.fromJson(JsonFormat json) {
    return FavoriteRatingDto(
      source: json['Source'],
      value: json['Value'],
    );
  }
}
