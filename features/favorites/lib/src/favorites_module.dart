import 'package:core/presentation.dart';
import 'package:flutter/widgets.dart';

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

class FavoritesWidgetModule extends WidgetModule {
  FavoritesWidgetModule({super.key});

  @override
  List<Bind<Object>> get binds => [];

  @override
  Widget get view => const MovieListPage();
}