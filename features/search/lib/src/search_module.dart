import 'package:core/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/search/data/remote_search_movie_repository.dart';
import 'features/search/domain/interfaces/search_movie_repository.dart';
import 'features/search/domain/interfaces/search_movie_use_case.dart';
import 'features/search/domain/usecases/search_movies.dart';
import 'features/search/presentation/controller/search_page_controller.dart';
import 'features/search/presentation/pages/search_page.dart';

class SearchModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // Repository
        Bind.lazySingleton<SearchMovieRepository>(
          (i) => RemoteSearchMovieRepository(
            dio: i.get<Dio>(),
          ),
        ),
        // UseCase
        Bind.lazySingleton<SearchMovieUseCase>(
          (i) => SearchMovie(
            repository: i.get<SearchMovieRepository>(),
          ),
        ),
        // Controller
        Bind.lazySingleton(
          (i) => SearchPageController(
            searchMovieUseCase: i.get<SearchMovieUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SearchPage(),
        ),
      ];
}
