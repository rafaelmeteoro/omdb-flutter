import 'package:app_core/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/core/errors/failure.dart';

void main() {
  group('search failure', () {
    test('result search failure', () {
      // Arrange
      final resultFailure = ResultSearchFailure(message: 'result failure');

      // Assert
      expect(resultFailure, isA<ResultSearchFailure>());
      expect(resultFailure, isA<Failure>());
      expect(
        resultFailure == ResultSearchFailure(message: 'result failure'),
        equals(true),
      );
    });
  });
}
