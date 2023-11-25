import 'package:core/presentation.dart';

import '../../movie_storage_manager.dart';

class MovieStorageModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..add<HiveInterface>(() => Hive)
      ..add<MovieStorage>(HiveMovieStorage.new);
  }
}
