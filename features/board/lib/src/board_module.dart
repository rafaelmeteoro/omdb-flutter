import 'package:core/presentation.dart';
import 'package:favorites/favorites.dart';
import 'package:words/words.dart';

import 'features/board/presentation/page/board_page.dart';
import 'features/board/presentation/page/board_page_delegate.dart';

class BoardModule extends Module {
  @override
  void binds(Injector i) {
    // Delegate
    i.add<BoardPageDelegate>(BoardPageFlow.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => BoardPage(
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
    );
  }
}
