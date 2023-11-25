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
  void binds(Injector i) {
    i
      // Repository
      ..addLazySingleton<MovieDetailRepository>(
        RemoteMovieDetailRepository.new,
      )
      ..addLazySingleton<MovieStorageRepository>(
        LocalMovieStorageRepository.new,
      )
      // UseCase
      ..addLazySingleton<GetMovieDetailUseCase>(
        GetMovieDetail.new,
      )
      ..addLazySingleton<ContainsMovieStorageUseCase>(
        ContainsMovie.new,
      )
      ..addLazySingleton<AddRemoveMovieStorageUseCase>(
        AddRemoveMovie.new,
      )
      // Controller
      ..addLazySingleton<MoviePageController>(
        MoviePageController.new,
      )
      ..addLazySingleton<MovieDetailContentController>(
        MovieDetailContentController.new,
      )
      ..addLazySingleton<MovieAddRemoveController>(
        MovieAddRemoveController.new,
      );
  }

  @override
  List<Module> get imports => [
        CoreModule(),
        MovieStorageModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => MoviePage(
        id: r.args.data as String,
        controller: context.read<MoviePageController>(),
        contentController: context.read<MovieDetailContentController>(),
        addRemoveController: context.read<MovieAddRemoveController>(),
      ),
    );
  }
}
