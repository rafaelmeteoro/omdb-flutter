import 'package:core/domain.dart';
import 'package:movie/src/domain/entities/rating.dart';

class MovieDetail extends Equatable {
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
  final String dvd;
  final String boxOffice;
  final List<Rating> ratings;

  const MovieDetail({
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
    required this.dvd,
    required this.boxOffice,
    required this.ratings,
  });

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
        dvd,
        boxOffice,
        ratings
      ];
}
