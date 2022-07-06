import 'package:flutter_test/flutter_test.dart';
import 'package:omdb_flutter/app/core/api_config.dart';

void main() {
  group('Api Config', () {
    test('should be same url and token when instanciate', () {
      final apiConfig = ApiConfig(
        baseUrl: 'https://anything.com',
        apiToken: 'token',
      );

      expect(apiConfig.baseUrl, equals('https://anything.com'));
      expect(apiConfig.apiToken, equals('token'));
    });
  });
}
