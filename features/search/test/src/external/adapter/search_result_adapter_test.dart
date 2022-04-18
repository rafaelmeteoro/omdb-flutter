import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/domain/entities/movie.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/external/adapter/search_result_adapter.dart';

void main() {
  group('search result adapter', () {
    test('from Json', () {
      // Arrange
      final Map<String, dynamic> map = {
        'Title': 'title',
        'Year': 'year',
        'imdbID': 'imdbid',
        'Type': 'type',
        'Poster': 'poster',
      };
      final Map<String, dynamic> json = {
        'Search': [map],
        'totalResults': '0',
        'Response': 'true',
      };

      // Act
      final result = SearchResultAdapter.fromJson(json);

      // Assert
      expect(result, isA<ResultSearch>());
      expect(result.search, isA<List<Movie>>());
      expect(result.totalResults, equals('0'));
      expect(result.response, equals('true'));
    });
  });
}
