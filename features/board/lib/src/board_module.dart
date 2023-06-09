import 'package:core/presentation.dart';
import 'package:favorites/favorites.dart';
import 'package:words/words.dart';

import 'features/board/presentation/page/board_page.dart';
import 'features/board/presentation/page/board_page_delegate.dart';

class BoardModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // Delegate
        Bind.factory<BoardPageDelegate>(
          (i) => BoardPageFlow(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => BoardPage(
            delegate: Modular.get<BoardPageDelegate>(),
          ),
          children: [
            ModuleRoute(
              '/favorites',
              module: FavoritesModule(),
              transition: TransitionType.noTransition,
            ),
            ModuleRoute(
              '/words',
              module: WordsModule(),
              transition: TransitionType.noTransition,
            ),
          ],
        )
      ];
}
