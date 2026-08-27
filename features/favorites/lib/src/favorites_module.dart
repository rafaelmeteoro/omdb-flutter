import 'package:core/presentation.dart';

import 'features/list/data/local_favorites_movie_storage_repository.dart';
import 'features/list/domain/interfaces/favorite_movie_storage_repository.dart';
import 'features/list/domain/interfaces/get_movies_use_case.dart';
import 'features/list/domain/usecases/get_movies.dart';
import 'features/list/presentation/controller/movie_list_page_controller.dart';
import 'features/list/presentation/pages/movie_list_page.dart';

/// Favorites list. Path-less on purpose: it is mounted only inside the board
/// `RouterOutlet` (`boardModule`), and flutter_modular 7.1.0's outlet does not
/// activate feature-scoped (path-bearing) module DI for its children — so the
/// binds must be root-owned to be reachable via `inject<T>()` from the outlet.
/// `movieStorageModule` (MovieStorage) is likewise root-owned.
final favoritesModule = createModule(
  register: (c) {
    c
      ..addLazySingleton<FavoriteMovieStorageRepository>(
        LocalFavoritesMovieStorageRepository.new,
      )
      ..addLazySingleton<GetMoviesUseCase>(GetMovies.new)
      ..add<MovieListPageController>(MovieListPageController.new)
      ..route(
        '/favorites',
        child: (ctx, state) => MovieListPage(
          controller: inject<MovieListPageController>(),
        ),
      );
  },
);
