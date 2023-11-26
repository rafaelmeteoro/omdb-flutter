import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/core/typedef/signatures.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/domain/interfaces/words_storage_use_case.dart';
import 'package:search/src/features/search/presentation/controller/search_page_controller.dart';
import 'package:search/src/features/search/presentation/controller/search_page_state.dart';
import 'package:search/src/features/search/presentation/pages/search_page.dart';
import 'package:search/src/features/search/presentation/pages/search_page_delegate.dart';

class SearchMovieUseCaseMock extends Mock implements SearchMovieUseCase {}

class WordsStorageUseCaseMock extends Mock implements WordsStorageUseCase {}

class SearchPageDelegateMock extends Mock implements SearchPageDelegate {}

void main() {
  late SearchMovieUseCase mockSearchUseCase;
  late WordsStorageUseCase mockWodsStorageUseCase;
  late SearchPageDelegate mockNavigate;
  late SearchPageController controller;

  setUp(() {
    mockSearchUseCase = SearchMovieUseCaseMock();
    mockWodsStorageUseCase = WordsStorageUseCaseMock();
    mockNavigate = SearchPageDelegateMock();
    controller = SearchPageController(
      searchMovieUseCase: mockSearchUseCase,
      wordsStorageUseCase: mockWodsStorageUseCase,
    );
  });

  group(SearchPage, () {
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

    testWidgets('show icon favorites and click', (tester) async {
      // Arrange
      when(() => mockNavigate.onActionClick()).thenAnswer(
        (_) async => Future.value(),
      );

      // Act
      await tester.pumpWidget(searchPageApp());
      var favoriteIcon = find.byKey(Key('favorite_icon'));
      await tester.tap(favoriteIcon);

      // Assert
      expect(favoriteIcon, findsOneWidget);
      verify(() => mockNavigate.onActionClick()).called(1);
    });

    testWidgets('show loading', (tester) async {
      // Act
      await tester.pumpWidget(searchPageApp());
      controller.value = SearchPageStateLoading();
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
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
      when(() => mockSearchUseCase.call(query: 'query')).thenAnswer(
        (_) async => Future.value(ResultSearch.right(resultEntity)),
      );
      when(() => mockWodsStorageUseCase.call(query: 'query')).thenAnswer(
        (_) async => right(unit),
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

    testWidgets('click item when receive success', (tester) async {
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
      when(() => mockSearchUseCase.call(query: 'query')).thenAnswer(
        (_) async => Future.value(ResultSearch.right(resultEntity)),
      );
      when(() => mockWodsStorageUseCase.call(query: 'query')).thenAnswer(
        (_) async => right(unit),
      );
      when(
        () => mockNavigate.onItemSearchSelected(movieId: 'imdbId'),
      ).thenAnswer((_) async => Future.value());

      // Act
      await tester.pumpWidget(searchPageApp());
      var textField = find.byKey(Key('search_text_field'));
      await tester.tap(textField);
      await tester.enterText(textField, 'query');
      await tester.pump(Duration(milliseconds: 700));
      var itemCard = find.byKey(Key('itemCard'));
      await tester.tap(itemCard);

      // Assert
      verify(
        () => mockNavigate.onItemSearchSelected(movieId: 'imdbId'),
      ).called(1);
    });

    testWidgets('show error message', (tester) async {
      // Arrange
      when(() => mockSearchUseCase.call(query: 'query')).thenAnswer(
        (_) async => Future.value(
          ResultSearch.left(ShortTitleFailure(message: 'short title')),
        ),
      );
      when(() => mockWodsStorageUseCase.call(query: 'query')).thenAnswer(
        (_) async => right(unit),
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
