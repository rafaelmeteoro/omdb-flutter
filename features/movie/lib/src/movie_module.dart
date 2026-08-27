import 'package:core/presentation.dart';

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

/// Movie detail feature, mounted at `/movie`. Opened with
/// `context.pushNamed('/movie/', arguments: <imdbId>)`; the id is read back
/// from `state.arguments`. `coreModule` + `movieStorageModule` are root-owned.
final movieModule = createModule(
  path: '/movie',
  register: (c) {
    c
      ..addLazySingleton<MovieDetailRepository>(RemoteMovieDetailRepository.new)
      ..addLazySingleton<MovieStorageRepository>(LocalMovieStorageRepository.new)
      ..addLazySingleton<GetMovieDetailUseCase>(GetMovieDetail.new)
      ..addLazySingleton<ContainsMovieStorageUseCase>(ContainsMovie.new)
      ..addLazySingleton<AddRemoveMovieStorageUseCase>(AddRemoveMovie.new)
      ..addLazySingleton<MoviePageController>(MoviePageController.new)
      ..addLazySingleton<MovieDetailContentController>(
        MovieDetailContentController.new,
      )
      ..addLazySingleton<MovieAddRemoveController>(MovieAddRemoveController.new)
      ..route(
        '/',
        child: (ctx, state) => MoviePage(
          id: state.arguments! as String,
          controller: inject<MoviePageController>(),
          contentController: inject<MovieDetailContentController>(),
          addRemoveController: inject<MovieAddRemoveController>(),
        ),
      );
  },
);
