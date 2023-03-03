import 'package:core/presentation.dart';

import 'features/favorites/presentation/pages/favorites_page.dart';

class FavoritesModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const FavoritesPage(),
        )
      ];
}
