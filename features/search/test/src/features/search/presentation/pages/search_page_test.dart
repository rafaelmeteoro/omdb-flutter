import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:search/src/core/typedef/signatures.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/presentation/controller/search_page_controller.dart';
import 'package:search/src/features/search/presentation/pages/search_page.dart';

class SearchMovieUseCaseMock extends Mock implements SearchMovieUseCase {}

void main() {
  late SearchMovieUseCase mockUseCase;
  late SearchPageController controller;

  setUp(() {
    mockUseCase = SearchMovieUseCaseMock();
    controller = SearchPageController(searchMovieUseCase: mockUseCase);
  });

  group('SearchPage', () {
    Widget searchPageApp() {
      return MaterialApp(
        home: Material(
          child: SearchPage(
            controller: controller,
          ),
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

    testWidgets('show text input text', (tester) async {
      // Arrange
      final resultEntity = ResultSearchEntity(
        search: [
          MovieEntity(
            imdbId: 'imdbId',
            title: 'title',
            year: 'year',
            type: 'type',
            poster: 'poster',
          )
        ],
        totalResults: '1',
        response: 'True',
      );
      when(() => mockUseCase.call(query: 'query')).thenAnswer(
        (_) async => Future.value(ResultSearch.right(resultEntity)),
      );

      // Act
      await tester.pumpWidget(searchPageApp());
      await tester.enterText(find.byKey(Key('search_text_field')), 'query');

      // Assert
      expect(find.text('query'), findsOneWidget);
    });
  });
}
