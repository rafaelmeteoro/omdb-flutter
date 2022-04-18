import 'package:search/src/domain/entities/movie.dart';

class SearchMovieAdapter {
  static Movie fromJson(Map<String, dynamic> json) => Movie(
        imdbId: json['imdbID'],
        title: json['Title'],
        year: json['Year'],
        type: json['Type'],
        poster: json['Poster'],
      );
}
