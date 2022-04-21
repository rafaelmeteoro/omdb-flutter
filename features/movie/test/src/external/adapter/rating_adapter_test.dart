import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/domain/entities/rating.dart';
import 'package:movie/src/external/adapter/rating_adapter.dart';

void main() {
  group('rating adapter', () {
    test('from Json', () {
      // Arrange
      final Map<String, dynamic> json = {
        'Source': 'source',
        'Value': 'value',
      };

      // Act
      final result = RatingAdapter.fromJson(json);

      // Assert
      expect(result, isA<Rating>());
      expect(result.source, equals('source'));
      expect(result.value, equals('value'));
    });
  });
}
