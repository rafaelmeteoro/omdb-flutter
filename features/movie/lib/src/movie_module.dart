import 'package:core/domain.dart';
import 'package:core/presentation.dart';
import 'package:movie_storage_manager/movie_storage_manager.dart';

import 'features/movie/data/local_movie_storage_repository.dart';
import 'features/movie/data/remote_movie_detail_repository.dart';
import 'features/movie/domain/interfaces/add_remove_movie_storage_use_case.dart';
import 'features/movie/domain/interfaces/contains_movie_storage_use_case.dart';
import 'features/movie/domain/interfaces/get_movie_detail_use_case.dart';
import 'features/movie/domain/interfaces/movie_detail_repository.dart';
import 'features/movie/domain/interfaces/movie_storage_repository.dart';
import 'features/movie/domain/usecases/add_remove_movie.dart';
import 'features/movie/domain/usecases/contains_movie.dart';
import 'features/movie/domain/usecases/get_movie_detail.dart';
import 'features/movie/presentation/controller/movie_add_remove_controller.dart';
import 'features/movie/presentation/controller/movie_detail_content_controller.dart';
import 'features/movie/presentation/controller/movie_page_controller.dart';
import 'features/movie/presentation/pages/movie_page.dart';

class MovieModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // Repository
        Bind.lazySingleton<MovieDetailRepository>(
          (i) => RemoteMovieDetailRepository(
            dio: i.get<Dio>(),
          ),
        ),
        Bind.lazySingleton<MovieStorageRepository>(
          (i) => LocalMovieStorageRepository(
            storage: i.get<MovieStorage>(),
          ),
        ),

        // UseCase
        Bind.lazySingleton<GetMovieDetailUseCase>(
          (i) => GetMovieDetail(
            repository: i.get<MovieDetailRepository>(),
          ),
        ),
        Bind.lazySingleton<ContainsMovieStorageUseCase>(
          (i) => ContainsMovie(
            repository: i.get<MovieStorageRepository>(),
          ),
        ),
        Bind.lazySingleton<AddRemoveMovieStorageUseCase>(
          (i) => AddRemoveMovie(
            repository: i.get<MovieStorageRepository>(),
          ),
        ),

        // Controller
        Bind.lazySingleton<MoviePageController>(
          (i) => MoviePageController(
            getMovieDetailUseCase: i.get<GetMovieDetailUseCase>(),
          ),
        ),
        Bind.lazySingleton<MovieDetailContentController>(
          (i) => MovieDetailContentController(
            containsMovieStorageUseCase: i.get<ContainsMovieStorageUseCase>(),
          ),
        ),
        Bind.lazySingleton<MovieAddRemoveController>(
          (i) => MovieAddRemoveController(
            useCase: i.get<AddRemoveMovieStorageUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => MoviePage(
            id: args.data as String,
            controller: context.read<MoviePageController>(),
            contentController: context.read<MovieDetailContentController>(),
            addRemoveController: context.read<MovieAddRemoveController>(),
          ),
        ),
      ];
}
