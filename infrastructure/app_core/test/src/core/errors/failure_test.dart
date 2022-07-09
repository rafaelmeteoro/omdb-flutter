import 'package:app_core/failures.dart';
import 'package:flutter_test/flutter_test.dart';

class CustomFailure extends Failure {
  CustomFailure(String? message) : super(message);
}

void main() {
  group('failure', () {
    test('custom failure', () {
      // Arrange
      final exception = CustomFailure('custom failure');

      // Assert
      expect(exception, isA<CustomFailure>());
      expect(exception, isA<Failure>());
      expect(exception.message, equals('custom failure'));
    });

    test('has failures equal', () {
      // Arrange
      final custom = CustomFailure('failure message');

      // Assert
      expect(custom == CustomFailure('failure message'), equals(true));
    });

    test('server failure', () {
      // Arrange
      final server = ServerFailure(message: 'server message');

      // Assert
      expect(server == ServerFailure(message: 'server message'), equals(true));
    });
  });
}
