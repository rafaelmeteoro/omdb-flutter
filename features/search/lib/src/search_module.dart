import 'package:flutter_modular/flutter_modular.dart';
import 'package:search/src/presentation/pages/search_page.dart';

class SearchModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SearchPage(),
        ),
      ];
}
