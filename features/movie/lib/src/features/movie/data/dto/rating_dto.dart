import 'package:app_core/app_core.dart';

import '../../domain/entities/rating_entity.dart';

class RatingDto extends RatingEntity {
  const RatingDto({
    required super.source,
    required super.value,
  });

  factory RatingDto.fromJson(JsonFormat json) {
    return RatingDto(
      source: json['Source'],
      value: json['Value'],
    );
  }

  factory RatingDto.fromEntity(RatingEntity entity) {
    return RatingDto(
      source: entity.source,
      value: entity.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Source': source,
      'Value': value,
    };
  }
}
