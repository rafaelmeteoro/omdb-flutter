import 'package:app_core/app_core.dart';

import '../../domain/entities/movie_entity.dart';

class MovieDto extends MovieEntity {
  const MovieDto({
    required String imdbId,
    required String title,
    required String year,
    required String type,
    required String poster,
  }) : super(
          imdbId: imdbId,
          title: title,
          year: year,
          type: type,
          poster: poster,
        );

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
