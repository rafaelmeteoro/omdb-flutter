import 'package:flutter_test/flutter_test.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';

void main() {
  group('home failures test', () {
    test('should be home short title', () {
      // Arrange
      final failure = HomeShortTitleFailure(
        message: 'short title failure test',
      );

      // Assert
      expect(failure, isA<HomeShortTitleFailure>());
    });
  });
}
