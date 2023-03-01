import 'package:app_core/app_core.dart';

import '../../domain/entities/movie_entity.dart';

class MovieDto extends MovieEntity {
  const MovieDto({
    required super.imdbId,
    required super.title,
    required super.year,
    required super.type,
    required super.poster,
  });

  factory MovieDto.fromJson(JsonFormat json) {
    return MovieDto(
      imdbId: json['imdbID'],
      title: json['Title'],
      year: json['Year'],
      type: json['Type'],
      poster: json['Poster'],
    );
  }
}
