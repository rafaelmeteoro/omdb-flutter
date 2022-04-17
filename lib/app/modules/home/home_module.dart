import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omdb_flutter/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:omdb_flutter/app/modules/home/domain/usecases/get_movies.dart';
import 'package:omdb_flutter/app/modules/home/external/datasources/home_remote_datasource.dart';
import 'package:omdb_flutter/app/modules/home/infra/datasources/home_remote_datasource_interface.dart';
import 'package:omdb_flutter/app/modules/home/infra/repositories/home_repository.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:omdb_flutter/app/modules/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // DataSource
        Bind.lazySingleton<IHomeRemoteDatasource>(
          (i) => HomeRemoteDatasource(
            dio: i.get<Dio>(),
          ),
        ),
        // Repository
        Bind.lazySingleton<IHomeMovieRepository>(
          (i) => HomeMovieRepository(
            homeRemoteDatasource: i.get<IHomeRemoteDatasource>(),
          ),
        ),
        // UseCase
        Bind.lazySingleton<IGetMoviesUseCase>(
          (i) => GetMoviesUseCase(
            homeMovieRepository: i.get<IHomeMovieRepository>(),
          ),
        ),
        // Cubit
        Bind.lazySingleton<HomeCubit>(
          (i) => HomeCubit(
            getMoviesUseCase: i.get<IGetMoviesUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => HomePage(
            homeCubit: Modular.get<HomeCubit>(),
          ),
        ),
      ];
}
