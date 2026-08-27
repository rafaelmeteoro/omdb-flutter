import 'package:core/presentation.dart';

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

/// Landing feature, mounted at `/`. `coreModule` (Dio) and `wordsStorageModule`
/// (WordsStorage) are root-owned and resolved from the shared graph by type.
final searchModule = createModule(
  path: '/',
  register: (c) {
    c
      ..addLazySingleton<SearchMovieRepository>(RemoteSearchMovieRepository.new)
      ..addLazySingleton<WordsStorageRepository>(LocalWordsStorageRepository.new)
      ..addLazySingleton<SearchMovieUseCase>(SearchMovie.new)
      ..addLazySingleton<WordsStorageUseCase>(SaveQuery.new)
      ..addLazySingleton<SearchPageController>(SearchPageController.new)
      ..add<SearchPageDelegate>(SearchPageFlow.new)
      ..route(
        '/',
        child: (ctx, state) => SearchPage(
          controller: inject<SearchPageController>(),
          navigate: inject<SearchPageDelegate>(),
        ),
      );
  },
);
