import 'package:flutter_test/flutter_test.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';

void main() {
  group('home failures test', () {
    test('should be home short title failure', () {
      // Arrange
      final failure = HomeShortTitleFailure(
        message: 'short title failure test',
      );

      // Assert
      expect(failure, isA<HomeShortTitleFailure>());
    });

    test('should be home data source failure', () {
      // Arrange
      final failure = HomeDataSourceFailure(
        message: 'data source failure test',
      );

      // Assert
      expect(failure, isA<HomeDataSourceFailure>());
    });

    test('should be home parse failure', () {
      // Arrange
      final failure = HomeParseFailure(
        message: 'parse failure test',
      );

      // Assert
      expect(failure, isA<HomeParseFailure>());
    });

    test('should be unknown failure', () {
      // Arrange
      final failure = HomeUnknownFailure(
        message: 'unknown failure test',
      );

      // Assert
      expect(failure, isA<HomeUnknownFailure>());
    });
  });
}
