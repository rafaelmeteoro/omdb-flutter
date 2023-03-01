import 'package:app_core/app_core.dart';

import '../../domain/entities/result_search_entity.dart';
import 'movie_dto.dart';

class ResultSearchDto extends ResultSearchEntity {
  const ResultSearchDto({
    required List<MovieDto> super.search,
    required super.totalResults,
    required super.response,
  });

  factory ResultSearchDto.fromJson(JsonFormat json) {
    return ResultSearchDto(
      search: _parseMovies(json),
      totalResults: json['totalResults'],
      response: json['Response'],
    );
  }

  static List<MovieDto> _parseMovies(JsonFormat json) {
    if (json['Search'] == null) {
      return [];
    }

    return (json['Search'] as List<dynamic>)
        .map((e) => e as JsonFormat)
        .map((e) => MovieDto.fromJson(e))
        .toList();
  }
}
