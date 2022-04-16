import 'package:flutter_test/flutter_test.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/external/adapter/home_entity_adapter.dart';

void main() {
  group('home entity adapter', () {
    test('from Map', () {
      // Arrange
      final Map<String, dynamic> map = {
        'Title': 'title',
        'Year': 'year',
        'imdbID': 'imdbid',
        'Type': 'type',
        'Poster': 'poster',
      };

      // Act
      final result = HomeMovieEntityAdapter.fromMap(map: map);

      // Assert
      expect(result, isA<HomeMovieEntity>());
      expect(result.title, 'title');
      expect(result.year, 'year');
      expect(result.imdbId, 'imdbid');
      expect(result.type, 'type');
      expect(result.poster, 'poster');
    });

    test('from Map Root', () {
      // Arrange
      final Map<String, dynamic> map = {
        'Title': 'title',
        'Year': 'year',
        'imdbID': 'imdbid',
        'Type': 'type',
        'Poster': 'poster',
      };
      final Map<String, dynamic> searchResult = {
        'Search': [map],
        'totalResults': '0',
        'Response': 'true',
      };

      // Act
      final result = HomeMovieEntityAdapter.fromMapRoot(map: searchResult);

      // Assert
      expect(result, isA<ResultSearch>());
      expect(result.search, isA<List<HomeMovieEntity>>());
      expect(result.totalResults, '0');
      expect(result.response, 'true');
    });
  });
}
