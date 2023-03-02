import 'package:dio/dio.dart';

import 'api_config.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({
    required ApiConfig apiConfig,
  }) : _apiConfig = apiConfig;

  final ApiConfig _apiConfig;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'apiKey': _apiConfig.apiToken,
    });
    super.onRequest(options, handler);
  }
}
