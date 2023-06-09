import 'package:board/src/features/board/domain/entities/board_type_entity.dart';
import 'package:board/src/features/board/presentation/page/board_page_delegate.dart';
import 'package:core/presentation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  late IModularNavigator navigate;
  late BoardPageDelegate delegate;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    navigate = ModularNavigateMock();
    Modular.navigatorDelegate = navigate;
    delegate = BoardPageFlow();
  });

  group(BoardPageFlow, () {
    test('navigate to route when navigateToRoute is called', () async {
      // Arrange
      final expectedRoute = '/board/favorites/';
      when(() => navigate.pushNamed(any())).thenAnswer(
        (_) async => Future.value(),
      );

      // act
      await delegate.navigateToRoute(route: BoardTypeEntity.favorites.route);

      // Assert
      verify(() => navigate.pushNamed(expectedRoute));
    });
  });
}
