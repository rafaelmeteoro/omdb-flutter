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
  List<Bind<Object>> get binds => [
        // Repository
        Bind.lazySingleton<FavoriteMovieStorageRepository>(
          (i) => LocalFavoritesMovieStorageRepository(
            storage: i.get<MovieStorage>(),
          ),
        ),

        // UseCase
        Bind.lazySingleton<GetMoviesUseCase>(
          (i) => GetMovies(
            repository: i.get<FavoriteMovieStorageRepository>(),
          ),
        ),

        // Controller
        Bind.factory<MovieListPageController>(
          (i) => MovieListPageController(
            useCase: i.get<GetMoviesUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => MovieListPage(
            controller: context.read<MovieListPageController>(),
          ),
        )
      ];
}
