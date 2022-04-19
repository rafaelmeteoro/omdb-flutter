import 'package:core/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('core custom exceptions', () {
    test('should be data source exception', () {
      // Arrange
      final exception = DataSourceException(message: 'data source exception');

      // Assert
      expect(exception, isA<DataSourceException>());
      expect(exception.message, equals('data source exception'));
    });

    test('should be no internet exception', () {
      // Arrange
      final exception = NoInternetException(message: 'no internet exception');

      // Assert
      expect(exception, isA<NoInternetException>());
      expect(exception.message, equals('no internet exception'));
    });
  });
}
