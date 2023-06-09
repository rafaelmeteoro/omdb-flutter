import 'package:board/src/features/board/domain/entities/board_type_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(BoardTypeEntity, () {
    test('return route from favorites', () async {
      // Arrange
      final expectedValue = '/board/favorites/';

      // Act
      final result = BoardTypeEntity.favorites;

      // Assert
      expect(result.route, expectedValue);
    });

    test('return route from words', () async {
      // Arrange
      final expectedValue = '/board/words/';

      // Act
      final result = BoardTypeEntity.words;

      // Assert
      expect(result.route, expectedValue);
    });
  });
}
