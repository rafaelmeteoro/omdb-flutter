import 'package:core/presentation.dart';
import 'package:dev_core/dev_core.dart';
import 'package:search/src/features/search/presentation/pages/search_page_delegate.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  late IModularNavigator navigate;
  late SearchPageDelegate delegate;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    navigate = ModularNavigateMock();
    Modular.navigatorDelegate = navigate;
    delegate = SearchPageFlow();
  });

  group(SearchPageFlow, () {
    test('call movie page when onItemSelected is called', () async {
      // Arrange
      when(
        () => navigate.pushNamed(any(), arguments: any(named: 'arguments')),
      ).thenAnswer((_) async => Future.value());

      // Act
      await delegate.onItemSearchSelected(movieId: 'movieId');

      // Assert
      verify(() => navigate.pushNamed('/movie/', arguments: 'movieId'));
    });

    test('call favorites page when onActionClick is called', () async {
      // Arrange
      when(
        () => navigate.pushNamed(any()),
      ).thenAnswer((_) async => Future.value());

      // Act
      await delegate.onActionClick();

      // Assert
      verify(() => navigate.pushNamed('/favorites/'));
    });
  });
}
