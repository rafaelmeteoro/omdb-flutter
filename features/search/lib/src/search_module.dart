import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search/src/features/search/domain/usecase/search_movies.dart';
import 'package:search/src/features/search/infra/repositories/search_movie_repository.dart';
import 'package:search/src/features/search/presentation/bloc/search_bloc.dart';
import 'package:search/src/features/search/presentation/pages/search_page.dart';

import 'features/search/domain/repositories/search_movie_repository_interface.dart';
import 'features/search/external/datasource/search_remote_datasource.dart';
import 'features/search/infra/datasource/search_remote_datasource_interface.dart';

class SearchModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // DataSource
        Bind.lazySingleton<SearchRemoteDataSourceContract>(
          (i) => SearchRemoteDataSource(
            dio: i.get<Dio>(),
          ),
        ),
        // Repository
        Bind.lazySingleton<SearchMovieRepositoryContract>(
          (i) => SearchMovieRepository(
            remoteDataSource: i.get<SearchRemoteDataSourceContract>(),
          ),
        ),
        // UseCase
        Bind.lazySingleton<SearchMoviesUseCaseContract>(
          (i) => SearchMoviesUseCase(
            searchRepository: i.get<SearchMovieRepositoryContract>(),
          ),
        ),
        // Bloc
        Bind.lazySingleton<SearchBloc>(
          (i) => SearchBloc(
            searchMoviesUseCase: i.get<SearchMoviesUseCaseContract>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => SearchPage(
            searchBloc: Modular.get<SearchBloc>(),
          ),
        ),
      ];
}
