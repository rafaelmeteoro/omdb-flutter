import 'package:core/presentation.dart';

import '../../movie_storage_manager.dart';

/// Path-less (shared DI) module: `HiveInterface` + `MovieStorage` are
/// root-owned. Also the single owner of the `HiveInterface` bind shared with
/// the words storage module — both are co-mounted at the app root, this one
/// first.
final movieStorageModule = createModule(
  register: (c) {
    c
      ..add<HiveInterface>(() => Hive)
      ..add<MovieStorage>(HiveMovieStorage.new);
  },
);
