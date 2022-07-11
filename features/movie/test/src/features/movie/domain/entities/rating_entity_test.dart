import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';

void main() {
  group('rating entity', () {
    test('rating has same parameters', () {
      // Arrange
      const rating = RatingEntity(
        source: 'source',
        value: 'value',
      );

      // Assert
      expect(rating, isA<RatingEntity>());
      expect(
        rating ==
            const RatingEntity(
              source: 'source',
              value: 'value',
            ),
        equals(true),
      );
    });
  });
}
