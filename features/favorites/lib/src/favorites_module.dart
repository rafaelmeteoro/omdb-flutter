import 'package:core/presentation.dart';
import 'package:movie_storage_manager/movie_storage_manager.dart';

import 'features/list/data/local_favorites_movie_storage_repository.dart';
import 'features/list/domain/interfaces/favorite_movie_storage_repository.dart';
import 'features/list/domain/interfaces/get_movies_use_case.dart';
import 'features/list/domain/usecases/get_movies.dart';
import 'features/list/presentation/controller/movie_list_page_controller.dart';
import 'features/list/presentation/pages/movie_list_page.dart';

class FavoritesModule extends Module {
  @override
  void binds(Injector i) {
    i
      // Repository
      ..addLazySingleton<FavoriteMovieStorageRepository>(
        LocalFavoritesMovieStorageRepository.new,
      )
      // UseCase
      ..addLazySingleton<GetMoviesUseCase>(
        GetMovies.new,
      )
      // Controller
      ..add<MovieListPageController>(MovieListPageController.new);
  }

  @override
  List<Module> get imports => [
        MovieStorageModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => MovieListPage(
        controller: context.read<MovieListPageController>(),
      ),
    );
  }
}
