import 'package:core/presentation.dart';

import '../../words_storage_manager.dart';

class WordsStorageModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..add<HiveInterface>(() => Hive)
      // Words Storage
      ..add<WordsStorage>(HiveWordsStorage.new);
  }
}
