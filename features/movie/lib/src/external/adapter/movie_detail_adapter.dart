import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/external/adapter/rating_adapter.dart';

class MovieDetailAdapter {
  static MovieDetail fromJson(Map<String, dynamic> json) => MovieDetail(
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
        dvd: json['DVD'],
        boxOffice: json['BoxOffice'],
        ratings: (json['Ratings'] as List)
            .map((rating) => RatingAdapter.fromJson(rating))
            .toList(),
      );

  static List<String> _splitAndList(String value) {
    final valueSplit = value.split(',');
    final result = valueSplit.map((e) => e.trim()).toList();
    return result;
  }
}
