import 'package:core/presentation.dart';
import 'package:words_storage_manager/words_storage_manager.dart';

import 'features/words/data/local_words_storage_repository.dart';
import 'features/words/domain/interfaces/delete_words_storage_use_case.dart';
import 'features/words/domain/interfaces/get_words_storage_use_case.dart';
import 'features/words/domain/interfaces/words_storage_repository.dart';
import 'features/words/domain/usecases/delete_words.dart';
import 'features/words/domain/usecases/get_words.dart';
import 'features/words/presentation/controller/words_page_controller.dart';
import 'features/words/presentation/pages/words_page.dart';

class WordsModule extends Module {
  @override
  void binds(Injector i) {
    i
      // Repository
      ..addLazySingleton<WordsStorageRepository>(
        LocalWordsStorageRepository.new,
      )
      // UseCase
      ..addLazySingleton<GetWordsStorageUseCase>(
        GetWords.new,
      )
      ..addLazySingleton<DeleteWordsStorageUseCase>(
        DeleteWords.new,
      )
      // Controller
      ..addLazySingleton<WordsPageController>(
        WordsPageController.new,
      );
  }

  @override
  List<Module> get imports => [
        WordsStorageModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => WordsPage(
        controller: context.read<WordsPageController>(),
      ),
    );
  }
}
