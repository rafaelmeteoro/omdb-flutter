import 'package:core/presentation.dart';
import 'package:favorites/favorites.dart';
import 'package:flutter/widgets.dart';
import 'package:words/words.dart';

import 'features/board/presentation/page/board_page.dart';

/// Persistent shell mounted at `/board`: [BoardPage] hosts a `RouterOutlet`
/// whose body swaps between the favorites and words features. The bare `/board`
/// route redirects to the first tab so the outlet always has a child.
final boardModule = createModule(
  path: '/board',
  register: (c) {
    c.route(
      '/',
      child: (ctx, state) => const BoardPage(),
      children: (sub) {
        sub
          ..route(
            '/',
            guards: [(state) => '/board/favorites'],
            child: (ctx, state) => const SizedBox.shrink(),
          )
          ..module(favoritesModule)
          ..module(wordsModule);
      },
    );
  },
);
