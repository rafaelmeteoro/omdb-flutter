import 'package:core/presentation.dart';

import '../../words_storage_manager.dart';

/// Path-less (shared DI) module: `WordsStorage` is root-owned. `HiveInterface`
/// is registered by the movie storage module (co-mounted at the app root
/// before this one) and resolved from the shared graph.
final wordsStorageModule = createModule(
  register: (c) {
    c.add<WordsStorage>(HiveWordsStorage.new);
  },
);
