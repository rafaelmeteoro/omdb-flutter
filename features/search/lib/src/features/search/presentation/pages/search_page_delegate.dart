import 'package:core/presentation.dart';

abstract class SearchPageDelegate {
  Future<void> onItemSearchSelected({
    required String movieId,
  });
  Future<void> onActionClick();
}

class SearchPageFlow implements SearchPageDelegate {
  @override
  Future<void> onItemSearchSelected({required String movieId}) async {
    await Modular.to.pushNamed(
      '/movie/',
      arguments: movieId,
    );
  }

  @override
  Future<void> onActionClick() async {
    await Modular.to.pushNamed('/favorites/');
  }
}
