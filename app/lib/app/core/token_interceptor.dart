import 'package:dio/dio.dart';

import 'api_config.dart';

class TokenInterceptor extends Interceptor {
  final ApiConfig _apiConfig;

  TokenInterceptor({
    required ApiConfig apiConfig,
  }) : _apiConfig = apiConfig;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'apiKey': _apiConfig.apiToken,
    });
    super.onRequest(options, handler);
  }
}
