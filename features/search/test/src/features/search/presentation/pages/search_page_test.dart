import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/core/typedef/signatures.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/presentation/controller/search_page_controller.dart';
import 'package:search/src/features/search/presentation/pages/search_page.dart';
import 'package:search/src/features/search/presentation/pages/search_page_delegate.dart';

class SearchMovieUseCaseMock extends Mock implements SearchMovieUseCase {}

class SearchPageDelegateMock extends Mock implements SearchPageDelegate {}

void main() {
  late SearchMovieUseCaseMock mockUseCase;
  late SearchPageDelegateMock mockNavigate;
  late SearchPageController controller;

  setUp(() {
    mockUseCase = SearchMovieUseCaseMock();
    mockNavigate = SearchPageDelegateMock();
    controller = SearchPageController(searchMovieUseCase: mockUseCase);
  });

  group('SearchPage', () {
    Widget searchPageApp() {
      return MaterialApp(
        home: Material(
          child: SearchPage(
            controller: controller,
            navigate: mockNavigate,
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
      var textField = find.byKey(Key('search_text_field'));
      await tester.tap(textField);
      await tester.enterText(textField, 'query');
      await tester.pump(Duration(milliseconds: 700));

      // Assert
      expect(find.text('query'), findsOneWidget);
    });

    testWidgets('show error message', (tester) async {
      // Arrange
      when(() => mockUseCase.call(query: 'query')).thenAnswer(
        (_) async => Future.value(
            ResultSearch.left(ShortTitleFailure(message: 'short title'))),
      );

      // Act
      await tester.pumpWidget(searchPageApp());
      var textField = find.byKey(Key('search_text_field'));
      await tester.tap(textField);
      await tester.enterText(textField, 'query');
      await tester.pump(Duration(milliseconds: 700));

      // Assert
      expect(find.text('short title'), findsOneWidget);
    });
  });
}
