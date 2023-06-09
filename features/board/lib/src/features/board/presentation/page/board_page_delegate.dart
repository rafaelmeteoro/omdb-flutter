import 'package:core/presentation.dart';

abstract class BoardPageDelegate {
  Future<void> navigateToRoute({
    required String route,
  });
}

class BoardPageFlow implements BoardPageDelegate {
  @override
  Future<void> navigateToRoute({required String route}) async {
    await Modular.to.pushNamed(route);
  }
}
