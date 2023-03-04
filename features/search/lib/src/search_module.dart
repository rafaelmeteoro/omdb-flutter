import 'package:core/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words_storage_manager/words_storage_manager.dart';

import 'features/search/data/local_words_storage_repository.dart';
import 'features/search/data/remote_search_movie_repository.dart';
import 'features/search/domain/interfaces/search_movie_repository.dart';
import 'features/search/domain/interfaces/search_movie_use_case.dart';
import 'features/search/domain/interfaces/words_storage_repository.dart';
import 'features/search/domain/interfaces/words_storage_use_case.dart';
import 'features/search/domain/usecases/save_query.dart';
import 'features/search/domain/usecases/search_movies.dart';
import 'features/search/presentation/controller/search_page_controller.dart';
import 'features/search/presentation/pages/search_page.dart';
import 'features/search/presentation/pages/search_page_delegate.dart';

class SearchModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // Repository
        Bind.lazySingleton<SearchMovieRepository>(
          (i) => RemoteSearchMovieRepository(
            dio: i.get<Dio>(),
          ),
        ),
        Bind.lazySingleton<WordsStorageRepository>(
          (i) => LocalWordsStorageRepository(
            storage: i.get<WordsStorage>(),
          ),
        ),

        // UseCase
        Bind.lazySingleton<SearchMovieUseCase>(
          (i) => SearchMovie(
            repository: i.get<SearchMovieRepository>(),
          ),
        ),
        Bind.lazySingleton<WordsStorageUseCase>(
          (i) => SaveQuery(
            repository: i.get<WordsStorageRepository>(),
          ),
        ),

        // Controller
        Bind.lazySingleton<SearchPageController>(
          (i) => SearchPageController(
            searchMovieUseCase: i.get<SearchMovieUseCase>(),
            wordsStorageUseCase: i.get<WordsStorageUseCase>(),
          ),
        ),

        // Delegate
        Bind.factory<SearchPageDelegate>(
          (i) => SearchPageFlow(),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => SearchPage(
            controller: context.read<SearchPageController>(),
            navigate: context.read<SearchPageDelegate>(),
          ),
        ),
      ];
}
