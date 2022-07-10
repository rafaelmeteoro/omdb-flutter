import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:omdb_flutter/app/core/api_config.dart';
import 'package:omdb_flutter/app/core/token_interceptor.dart';

class MockRequestHandler extends Mock implements RequestInterceptorHandler {}

class MockApiConfig extends Mock implements ApiConfig {}

void main() {
  late RequestOptions options;
  late RequestInterceptorHandler handler;
  late ApiConfig apiConfig;
  late TokenInterceptor interceptor;

  setUp(() {
    options = RequestOptions(path: 'htttp://path.com');
    handler = MockRequestHandler();
    apiConfig = MockApiConfig();
    interceptor = TokenInterceptor(apiConfig: apiConfig);
  });

  test('Request parameter header should not be null', () async {
    // Arrange
    when(() => apiConfig.apiToken).thenReturn('apiToken');

    // Act
    interceptor.onRequest(options, handler);

    // Assert
    expect(options.queryParameters['apiKey'], equals('apiToken'));
  });
}
