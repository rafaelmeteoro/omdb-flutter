import 'package:core/core.dart';
import 'package:movie/src/presentation/pages/movie_page.dart';

class MovieModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const MoviePage(),
        ),
      ];
}
