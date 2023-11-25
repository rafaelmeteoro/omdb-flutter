import 'package:core/presentation.dart';
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
  void binds(Injector i) {
    i
      // Repository
      ..addLazySingleton<SearchMovieRepository>(
        RemoteSearchMovieRepository.new,
      )
      ..addLazySingleton<WordsStorageRepository>(
        LocalWordsStorageRepository.new,
      )
      // UseCase
      ..addLazySingleton<SearchMovieUseCase>(
        SearchMovie.new,
      )
      ..addLazySingleton<WordsStorageUseCase>(
        SaveQuery.new,
      )
      // Controller
      ..addLazySingleton<SearchPageController>(
        SearchPageController.new,
      )
      // Delegate
      ..add<SearchPageDelegate>(
        SearchPageFlow.new,
      );
  }

  @override
  List<Module> get imports => [
        CoreModule(),
        WordsStorageModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => SearchPage(
        controller: context.read<SearchPageController>(),
        navigate: context.read<SearchPageDelegate>(),
      ),
    );
  }
}
