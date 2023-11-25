import 'package:core/utils/api_config.dart';
import 'package:core/utils/token_interceptor.dart';
import 'package:dev_core/dev_core.dart';
import 'package:dio/dio.dart';

class MockRequestHandler extends Mock implements RequestInterceptorHandler {}

class MockApiConfig extends Mock implements ApiConfig {}

void main() {
  late RequestOptions options;
  late RequestInterceptorHandler handler;
  late ApiConfig apiConfig;
  late TokenInterceptor interceptor;

  setUp(() {
    options = RequestOptions(path: 'http://path.com');
    handler = MockRequestHandler();
    apiConfig = MockApiConfig();
    interceptor = TokenInterceptor(apiConfig: apiConfig);
  });

  group(TokenInterceptor, () {
    test('Request parameter header should not be null', () async {
      // Arrange
      when(() => apiConfig.apiToken).thenReturn('apiToken');

      // Act
      interceptor.onRequest(options, handler);

      // Assert
      expect(options.queryParameters['apiKey'], equals('apiToken'));
    });
  });
}
