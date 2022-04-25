import '../../domain/entities/result_search_entity.dart';
import 'movie_dto.dart';

class ResultSearchDto extends ResultSearchEntity {
  const ResultSearchDto({
    required List<MovieDto> search,
    required String totalResults,
    String? response,
  }) : super(
          search: search,
          totalResults: totalResults,
          response: response,
        );

  factory ResultSearchDto.fromJson(Map<String, dynamic> json) {
    return ResultSearchDto(
      search: _parseMovies(json),
      totalResults: json['TotalResult'],
      response: json['Response'],
    );
  }

  static List<MovieDto> _parseMovies(Map<String, dynamic> json) {
    if (json['Search'] == null) return [];

    return (json['Search'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .map((e) => MovieDto.fromJson(e))
        .toList();
  }
}
