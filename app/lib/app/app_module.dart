import 'package:board/board.dart';
import 'package:core/presentation.dart';
import 'package:favorites/favorites.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:words/words.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r
      ..module('/', module: SearchModule())
      ..module('/movie', module: MovieModule())
      ..module('/favorites', module: FavoritesModule())
      ..module('/words', module: WordsModule())
      ..module('/board', module: BoardModule());
  }
}
