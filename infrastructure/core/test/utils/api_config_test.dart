import 'package:core/utils/api_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ApiConfig, () {
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
