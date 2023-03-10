import 'package:app_core/app_core.dart';

import '../../domain/entities/movie_detail_entity.dart';
import 'rating_dto.dart';

class MovieDetailDto extends MovieDetailEntity {
  const MovieDetailDto({
    required super.title,
    required super.year,
    required super.rated,
    required super.released,
    required super.runtime,
    required super.genre,
    required super.director,
    required super.writer,
    required super.actors,
    required super.plot,
    required super.language,
    required super.country,
    required super.awards,
    required super.poster,
    required super.metascore,
    required super.imdbRating,
    required super.imdbVotes,
    required super.imdbId,
    required super.type,
    required List<RatingDto> super.ratings,
  });

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
      ratings: (json['Ratings'] as List).map((e) => e as JsonFormat).map(RatingDto.fromJson).toList(),
    );
  }

  factory MovieDetailDto.fromEntity(MovieDetailEntity entity) {
    return MovieDetailDto(
      title: entity.title,
      year: entity.year,
      rated: entity.rated,
      released: entity.released,
      runtime: entity.runtime,
      genre: entity.genre,
      director: entity.director,
      writer: entity.writer,
      actors: entity.actors,
      plot: entity.plot,
      language: entity.language,
      country: entity.country,
      awards: entity.awards,
      poster: entity.poster,
      metascore: entity.metascore,
      imdbRating: entity.imdbRating,
      imdbVotes: entity.imdbVotes,
      imdbId: entity.imdbId,
      type: entity.type,
      ratings: entity.ratings.map(RatingDto.fromEntity).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'year': year,
      'rated': rated,
      'released': released,
      'runtime': runtime,
      'genre': genre,
      'director': director,
      'writer': writer,
      'actors': actors,
      'plot': plot,
      'language': language,
      'country': country,
      'awards': awards,
      'poster': poster,
      'metascore': metascore,
      'imdbRating': imdbRating,
      'imdbVotes': imdbVotes,
      'imdbId': imdbId,
      'type': type,
      'ratings': ratings,
    };
  }

  static List<String> _splitAndList(String value) {
    final valueSplit = value.split(',');
    return valueSplit.map((e) => e.trim()).toList();
  }
}
