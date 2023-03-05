import 'package:core/presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:words_storage_manager/words_storage_manager.dart';

import 'features/words/data/local_words_storage_repository.dart';
import 'features/words/domain/interfaces/get_words_storage_use_case.dart';
import 'features/words/domain/interfaces/words_storage_repository.dart';
import 'features/words/domain/usecases/get_words.dart';
import 'features/words/presentation/controller/words_page_controller.dart';
import 'features/words/presentation/pages/words_page.dart';

class WordsModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // Repository
        Bind.lazySingleton<WordsStorageRepository>(
          (i) => LocalWordsStorageRepository(
            storage: i.get<WordsStorage>(),
          ),
        ),

        // UseCase
        Bind.lazySingleton<GetWordsStorageUseCase>(
          (i) => GetWords(
            repository: i.get<WordsStorageRepository>(),
          ),
        ),

        // Controller
        Bind.lazySingleton<WordsPageController>(
          (i) => WordsPageController(
            getWordsStorageUseCase: i.get<GetWordsStorageUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const WordsPage(),
        )
      ];
}

class WordsWidgetModule extends WidgetModule {
  WordsWidgetModule({super.key});

  @override
  List<Bind<Object>> get binds => [
        // Repository
        Bind.lazySingleton<WordsStorageRepository>(
          (i) => LocalWordsStorageRepository(
            storage: i.get<WordsStorage>(),
          ),
        ),

        // UseCase
        Bind.lazySingleton<GetWordsStorageUseCase>(
          (i) => GetWords(
            repository: i.get<WordsStorageRepository>(),
          ),
        ),

        // Controller
        Bind.lazySingleton<WordsPageController>(
          (i) => WordsPageController(
            getWordsStorageUseCase: i.get<GetWordsStorageUseCase>(),
          ),
        ),
      ];

  @override
  Widget get view => const WordsPage();
}
