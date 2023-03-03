import 'package:core/presentation.dart';

import 'features/board/presentation/page/board_page.dart';

class BoardModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const BoardPage(),
        )
      ];
}
