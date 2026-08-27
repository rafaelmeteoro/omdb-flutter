import 'package:core/presentation.dart';

import 'features/words/data/local_words_storage_repository.dart';
import 'features/words/domain/interfaces/delete_words_storage_use_case.dart';
import 'features/words/domain/interfaces/get_words_storage_use_case.dart';
import 'features/words/domain/interfaces/words_storage_repository.dart';
import 'features/words/domain/usecases/delete_words.dart';
import 'features/words/domain/usecases/get_words.dart';
import 'features/words/presentation/controller/words_page_controller.dart';
import 'features/words/presentation/pages/words_page.dart';

/// Saved search words list. Path-less on purpose: it is mounted only inside the
/// board `RouterOutlet` (`boardModule`), and flutter_modular 7.1.0's outlet
/// does not activate feature-scoped (path-bearing) module DI for its children —
/// so the binds must be root-owned to be reachable via `inject<T>()` from the
/// outlet. `wordsStorageModule` (WordsStorage) is likewise root-owned.
final wordsModule = createModule(
  register: (c) {
    c
      ..addLazySingleton<WordsStorageRepository>(LocalWordsStorageRepository.new)
      ..addLazySingleton<GetWordsStorageUseCase>(GetWords.new)
      ..addLazySingleton<DeleteWordsStorageUseCase>(DeleteWords.new)
      ..addLazySingleton<WordsPageController>(WordsPageController.new)
      ..route(
        '/words',
        child: (ctx, state) => WordsPage(
          controller: inject<WordsPageController>(),
        ),
      );
  },
);
