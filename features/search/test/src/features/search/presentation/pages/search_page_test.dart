import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:search/search.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/presentation/controller/search_page_controller.dart';
import 'package:search/src/features/search/presentation/pages/search_page.dart';

class SearchMovieUseCaseMock extends Mock implements SearchMovieUseCase {}

void main() {
  late SearchMovieUseCase useCase;
  late SearchPageController controller;

  setUp(() {
    useCase = SearchMovieUseCaseMock();
    controller = SearchPageController(searchMovieUseCase: useCase);

    initModule(
      SearchModule(),
      replaceBinds: [
        Bind.instance<SearchMovieUseCase>(useCase),
        Bind.instance<SearchPageController>(controller),
      ],
    );
  });

  group('SearchPage', () {
    Widget searchPageApp() {
      return MaterialApp(
        home: Material(
          child: SearchPage(),
        ),
      );
    }

    testWidgets('show text empty when state is empty', (tester) async {
      // Act
      await tester.pumpWidget(searchPageApp());

      // Assert
      expect(
        find.text('Nenhum resultado encontrado. Faça uma pesquisa.'),
        findsOneWidget,
      );
    });
  });
}
