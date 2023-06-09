import 'package:core/presentation.dart';

import 'features/list/presentation/pages/movie_list_page.dart';

class FavoritesModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const MovieListPage(),
        )
      ];
}
