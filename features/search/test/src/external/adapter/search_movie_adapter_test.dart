import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/domain/entities/movie.dart';
import 'package:search/src/external/adapter/search_movie_adapter.dart';

void main() {
  group('search movie adapter', () {
    test('from Json', () {
      // Arrange
      final Map<String, dynamic> json = {
        'Title': 'title',
        'Year': 'year',
        'imdbID': 'imdbid',
        'Type': 'type',
        'Poster': 'poster',
      };

      // Act
      final result = SearchMovieAdapter.fromJson(json);

      // Assert
      expect(result, isA<Movie>());
      expect(result.title, equals('title'));
      expect(result.year, equals('year'));
      expect(result.imdbId, equals('imdbid'));
      expect(result.type, equals('type'));
      expect(result.poster, equals('poster'));
    });
  });
}
