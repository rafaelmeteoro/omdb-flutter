import 'package:app_core/app_core.dart';

import '../../domain/entities/movie_detail_entity.dart';
import 'rating_dto.dart';

class MovieDetailDto extends MovieDetailEntity {
  const MovieDetailDto({
    required String title,
    required String year,
    required String rated,
    required String released,
    required String runtime,
    required List<String> genre,
    required List<String> director,
    required List<String> writer,
    required List<String> actors,
    required String plot,
    required List<String> language,
    required List<String> country,
    required String awards,
    required String poster,
    required String metascore,
    required String imdbRating,
    required String imdbVotes,
    required String imdbId,
    required String type,
    required List<RatingDto> ratings,
  }) : super(
          title: title,
          year: year,
          rated: rated,
          released: released,
          runtime: runtime,
          genre: genre,
          director: director,
          writer: writer,
          actors: actors,
          plot: plot,
          language: language,
          country: country,
          awards: awards,
          poster: poster,
          metascore: metascore,
          imdbRating: imdbRating,
          imdbVotes: imdbVotes,
          imdbId: imdbId,
          type: type,
          ratings: ratings,
        );

  factory MovieDetailDto.fromJson(JsonFormat json) {
    return MovieDetailDto(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: _splitAndList(json['Genre']),
      director: _splitAndList(json['Director']),
      writer: _splitAndList(json['Writer']),
      actors: _splitAndList(json['Actors']),
      plot: json['Plot'],
      language: _splitAndList(json['Language']),
      country: _splitAndList(json['Country']),
      awards: json['Awards'],
      poster: json['Poster'],
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbId: json['imdbID'],
      type: json['Type'],
      ratings: (json['Ratings'] as List)
          .map((rating) => RatingDto.fromJson(rating))
          .toList(),
    );
  }

  static List<String> _splitAndList(String value) {
    final valueSplit = value.split(',');
    return valueSplit.map((e) => e.trim()).toList();
  }
}
