import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';

void main() {
  group('result search entity', () {
    test('result search has same parameters', () {
      // Arrange
      const result = ResultSearchEntity(
        search: [],
        totalResults: '0',
        response: 'response',
      );

      // Assert
      expect(result, isA<ResultSearchEntity>());
      expect(
        result ==
            const ResultSearchEntity(
              search: [],
              totalResults: '0',
              response: 'response',
            ),
        equals(true),
      );
    });
  });
}
