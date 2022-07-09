import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/data/dto/result_search_dto.dart';

void main() {
  group('result search dto', () {
    test('result search dto from json', () {
      // Arrange
      const json = {
        'TotalResult': '0',
        'Response': 'Response',
      };

      // Act
      final result = ResultSearchDto.fromJson(json);

      // Assert
      expect(result, isA<ResultSearchDto>());
      expect(
        result ==
            ResultSearchDto(
              search: [],
              totalResults: '0',
              response: 'Response',
            ),
        equals(true),
      );
    });
  });
}
