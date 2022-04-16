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
    test('should has failure class with stacktrace null', () {
      // Arrange
      final failure = TestFailure(
        message: 'message test',
        stackTrace: null,
        label: null,
      );

      // Assert
      expect(failure, isA<Failure>());
      expect(failure.message, equals('message test'));
      expect(failure.stackTrace, equals(null));
      expect(failure.label, equals(null));
    });

    test('should has failure class with stacktrace', () {
      // Arrange
      final stacktrace = ArgumentError().stackTrace;
      final failure = TestFailure(
        message: 'message test',
        stackTrace: stacktrace,
        label: null,
      );

      // Assert
      expect(failure, isA<Failure>());
      expect(failure.message, equals('message test'));
      expect(failure.stackTrace, equals(stacktrace));
      expect(failure.label, equals(null));
    });
  });
}
