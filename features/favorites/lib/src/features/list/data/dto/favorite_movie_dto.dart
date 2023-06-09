import 'package:app_core/app_core.dart';

import '../../domain/entities/favorite_movie_entity.dart';
import 'favorite_rating_dto.dart';

class FavoriteMovieDto extends FavoriteMovieEntity {
  const FavoriteMovieDto({
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
    required super.ratings,
  });

  factory FavoriteMovieDto.fromJson(JsonFormat json) {
    return FavoriteMovieDto(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbId: json['imdbID'],
      type: json['Type'],
      ratings: (json['Ratings'] as List).map((e) => e as JsonFormat).map(FavoriteRatingDto.fromJson).toList(),
    );
  }
}
