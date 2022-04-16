import 'package:flutter_test/flutter_test.dart';
import 'package:omdb_flutter/app/core/failures.dart';

class TestFailure extends Failure {
  TestFailure({
    required String message,
    required StackTrace? stackTrace,
    required String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

void main() {
  group('core failure tests', () {
    test('should has failure class', () {
      // Arrange
      final failure = TestFailure(
        message: 'message teste',
        stackTrace: null,
        label: null,
      );

      // Assert
      expect(failure, isA<Failure>());
    });
  });
}
