import 'package:board/board.dart';
import 'package:core/presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/movie.dart';
import 'package:movie_storage_manager/movie_storage_manager.dart';
import 'package:search/search.dart';
import 'package:words_storage_manager/words_storage_manager.dart';

/// Root module — composition only. Shared DI (path-less) modules are included
/// once here and seen by every feature by type; each feature declares its own
/// mount path. `/favorites` and `/words` are kept as redirects to the board
/// shell, which is where those features actually live.
final appModule = createModule(
  register: (c) {
    c
      ..module(coreModule)
      ..module(movieStorageModule)
      ..module(wordsStorageModule)
      ..module(searchModule)
      ..module(movieModule)
      ..module(boardModule)
      ..route(
        '/favorites',
        guards: [(state) => '/board/favorites'],
        child: (ctx, state) => const SizedBox.shrink(),
      )
      ..route(
        '/words',
        guards: [(state) => '/board/words'],
        child: (ctx, state) => const SizedBox.shrink(),
      );
  },
);
