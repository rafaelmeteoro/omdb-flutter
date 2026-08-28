import 'package:flutter_modular/flutter_modular.dart';

import '../domain.dart';
import '../utils/api_config.dart';
import '../utils/token_interceptor.dart';

/// Shared DATA layer — a path-less module, so its binds are root-owned and live
/// for the whole app. Included once by `appModule`; every feature resolves
/// `ApiConfig`/`Dio` from it by type (flutter_modular 7.1.0 upward resolution).
final coreModule = createModule(
  register: (c) {
    c
      ..addLazySingleton<ApiConfig>(
        () => ApiConfig(
          baseUrl: 'https://www.omdbapi.com',
          apiToken: '1abc75a6',
        ),
      )
      ..add<TokenInterceptor>(TokenInterceptor.new)
      ..addLazySingleton<Dio>(_buildDio);
  },
);

/// `auto_injector` resolves the positional params by type from the graph.
Dio _buildDio(ApiConfig config, TokenInterceptor tokenInterceptor) =>
    Dio(BaseOptions(baseUrl: config.baseUrl))
      ..interceptors.add(tokenInterceptor)
      ..interceptors.add(PrettyDioLogger());
