import 'package:core/failures/failures.dart';
import 'package:flutter_test/flutter_test.dart';

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
  group('core failures test', () {
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
      final stackTrace = ArgumentError().stackTrace;
      final failure = TestFailure(
        message: 'message test',
        stackTrace: stackTrace,
        label: null,
      );

      // Assert
      expect(failure, isA<Failure>());
      expect(failure.message, equals('message test'));
      expect(failure.stackTrace, equals(stackTrace));
      expect(failure.label, equals(null));
    });
  });
}
