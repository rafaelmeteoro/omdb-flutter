import 'package:core/domain.dart';
import 'package:core/presentation.dart';
import 'package:movie/src/domain/repositories/movie_detail_repository_interface.dart';
import 'package:movie/src/domain/usecase/get_movie_detail.dart';
import 'package:movie/src/external/datasource/movie_detail_remote_datasource.dart';
import 'package:movie/src/infra/datasource/movie_detail_remote_datasource_interface.dart';
import 'package:movie/src/infra/repositories/movie_detail_repository.dart';
import 'package:movie/src/presentation/bloc/movie_bloc.dart';
import 'package:movie/src/presentation/pages/movie_page.dart';

class MovieModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // DataSource
        Bind.lazySingleton<MovieDetailRemoteDataSourceContract>(
          (i) => MovieDetailRemoteDataSource(
            dio: i.get<Dio>(),
          ),
        ),
        // Repository
        Bind.lazySingleton<MovieDetailRepositoryContract>(
          (i) => MovieDetailRepository(
            remoteDataSource: i.get<MovieDetailRemoteDataSourceContract>(),
          ),
        ),
        // UseCase
        Bind.lazySingleton<GetMovieDetailUseCaseContract>(
          (i) => GetMovieDetailUseCase(
            movieDetailRepository: i.get<MovieDetailRepositoryContract>(),
          ),
        ),
        // Bloc
        Bind.lazySingleton<MovieBloc>(
          (i) => MovieBloc(
            getMovieDetailUseCase: i.get<GetMovieDetailUseCaseContract>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => MoviePage(
            movieBloc: Modular.get<MovieBloc>(),
            id: args.data as String,
          ),
        ),
      ];
}
