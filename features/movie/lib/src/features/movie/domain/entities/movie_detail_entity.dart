import 'package:core/domain.dart';

import 'rating_entity.dart';

class MovieDetailEntity extends Equatable {
  const MovieDetailEntity({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.ratings,
  });

  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final List<String> genre;
  final List<String> director;
  final List<String> writer;
  final List<String> actors;
  final String plot;
  final List<String> language;
  final List<String> country;
  final String awards;
  final String poster;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbId;
  final String type;
  final List<RatingEntity> ratings;

  @override
  List<Object?> get props => [
        title,
        year,
        rated,
        released,
        runtime,
        genre,
        director,
        writer,
        actors,
        plot,
        language,
        country,
        awards,
        poster,
        metascore,
        imdbRating,
        imdbVotes,
        imdbId,
        type,
        ratings,
      ];
}
