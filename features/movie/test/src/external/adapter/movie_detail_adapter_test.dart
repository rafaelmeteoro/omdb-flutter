import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/entities/rating.dart';
import 'package:movie/src/external/adapter/movie_detail_adapter.dart';

void main() {
  group('movie detail adapter', () {
    test('from Json', () {
      // Arrange
      final Map<String, dynamic> rating = {
        'Source': 'source',
        'Value': 'value',
      };
      final Map<String, dynamic> json = {
        'Title': 'title',
        'Year': 'year',
        'Rated': 'rated',
        'Released': 'released',
        'Runtime': 'Runtime',
        'Genre': 'genre1, genre2',
        'Director': 'director',
        'Writer': 'writer1, writer2',
        'Actors': 'actors1, actors2',
        'Plot': 'plot',
        'Language': 'language1, language2',
        'Country': 'country1, country2',
        'Awards': 'awards',
        'Poster': 'poster',
        'Metascore': 'metascore',
        'imdbRating': 'imdbRating',
        'imdbVotes': 'imdbVotes',
        'imdbID': 'imdbId',
        'Type': 'type',
        'DVD': 'dvd',
        'BoxOffice': 'boxOffice',
        'Ratings': [rating],
      };

      // Act
      final result = MovieDetailAdapter.fromJson(json);

      // Assert
      expect(result, isA<MovieDetail>());
      expect(result.ratings, isA<List<Rating>>());
      expect(result.genre, isA<List<String>>());
      expect(result.director, equals(['director']));
      expect(result.genre, equals(['genre1', 'genre2']));
    });
  });
}
