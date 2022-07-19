import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:search/search.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/presentation/controller/search_page_controller.dart';
import 'package:search/src/features/search/presentation/pages/search_page.dart';
import 'package:search/src/features/search/presentation/widgets/item_card_list.dart';

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

    testWidgets('show list card when state is success', (tester) async {
      // Arrange
      final searchResult = ResultSearchEntity(
        search: [
          MovieEntity(
            imdbId: 'imdbId1',
            title: 'title1',
            year: 'year1',
            type: 'type1',
            poster: 'poster1',
          ),
          MovieEntity(
            imdbId: 'imdbId2',
            title: 'title2',
            year: 'year2',
            type: 'type2',
            poster: 'poster2',
          ),
        ],
        response: 'True',
        totalResults: '2',
      );
      when(() => useCase.call(query: 'query')).thenAnswer(
        (_) async => right(searchResult),
      );

      // Act
      await tester.pumpWidget(searchPageApp());
      await tester.enterText(
        find.byKey(const Key('search_text_field')),
        'query',
      );
      // await controller.searchMovie(query: 'movie');
      await tester.pump(const Duration(seconds: 1));

      // Assert
      expect(find.text('query'), findsOneWidget);
      expect(find.text('Search Result'), findsOneWidget);
      expect(find.byType(ItemCard), findsNWidgets(2));
    });
  });
}
