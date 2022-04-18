import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omdb_flutter/app/core/api_config.dart';
import 'package:omdb_flutter/app/core/token_interceptor.dart';
import 'package:omdb_flutter/app/modules/home/home_module.dart';
import 'package:search/search.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // ApiConfig
        Bind.lazySingleton<ApiConfig>(
          (i) => ApiConfig(
            baseUrl: 'https://www.omdbapi.com',
            apiToken: '1abc75a6',
          ),
        ),
        // Dio
        Bind.lazySingleton<Dio>(
          (i) {
            final config = i.get<ApiConfig>();
            final baseOptions = BaseOptions(
              baseUrl: config.baseUrl,
            );
            final dio = Dio(baseOptions);
            dio.interceptors.add(TokenInterceptor(apiConfig: config));
            dio.interceptors.add(LogInterceptor(
              responseBody: true,
            ));
            return dio;
          },
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: SearchModule()),
      ];
}
