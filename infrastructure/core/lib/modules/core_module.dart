import 'package:flutter_modular/flutter_modular.dart';

import '../domain.dart';
import '../utils/api_config.dart';
import '../utils/token_interceptor.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      // ApiConfig
      ..addLazySingleton<ApiConfig>(
        () => ApiConfig(
          baseUrl: 'https://www.omdbapi.com',
          apiToken: '1abc75a6',
        ),
      )
      // Dio
      ..addLazySingleton<Dio>(
        () => Dio(
          BaseOptions(
            baseUrl: i.get<ApiConfig>().baseUrl,
          ),
        )
          ..interceptors.add(
            TokenInterceptor(
              apiConfig: i.get<ApiConfig>(),
            ),
          )
          ..interceptors.add(PrettyDioLogger()),
      );
  }
}
