import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:words/src/core/errors/failure.dart';
import 'package:words/src/core/typedef/signatures.dart';
import 'package:words/src/features/words/domain/interfaces/delete_words_storage_use_case.dart';
import 'package:words/src/features/words/domain/interfaces/get_words_storage_use_case.dart';
import 'package:words/src/features/words/presentation/controller/words_page_controller.dart';
import 'package:words/src/features/words/presentation/controller/words_page_state.dart';
import 'package:words/src/features/words/presentation/pages/words_page.dart';

class GetWordsStorageUseCaseMock extends Mock implements GetWordsStorageUseCase {}

class DeleteWordsStorageUseCaseMock extends Mock implements DeleteWordsStorageUseCase {}

void main() {
  late GetWordsStorageUseCase getWordsStorageUseCaseMock;
  late DeleteWordsStorageUseCase deleteWordsStorageUseCaseMock;
  late WordsPageController controller;

  setUp(() {
    getWordsStorageUseCaseMock = GetWordsStorageUseCaseMock();
    deleteWordsStorageUseCaseMock = DeleteWordsStorageUseCaseMock();
    controller = WordsPageController(
      getWordsStorageUseCase: getWordsStorageUseCaseMock,
      deleteWordsStorageUseCase: deleteWordsStorageUseCaseMock,
    );
  });

  group(WordsPage, () {
    Widget wordsPageApp() {
      return MaterialApp(
        home: Material(
          child: WordsPage(
            controller: controller,
          ),
        ),
      );
    }

    testWidgets('show text empty when state is empty', (tester) async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async => ResultGetWordsStorage.right([]),
      );

      // Act
      await tester.pumpWidget(wordsPageApp());

      // Assert
      expect(
        find.text('Nenhum resultado encontrado.'),
        findsOneWidget,
      );
    });

    testWidgets('show loading', (tester) async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async => ResultGetWordsStorage.right([]),
      );

      // Act
      await tester.pumpWidget(wordsPageApp());
      controller.value = WordsPageStateLoading();
      await tester.pump();

      // Assert
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
    });

    testWidgets('show error message', (tester) async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async =>
            ResultGetWordsStorage.left(WordsGetStorageFailure(message: 'no words')),
      );

      // Act
      await tester.pumpWidget(wordsPageApp());
      await tester.pump();

      // Assert
      expect(
        find.text('no words'),
        findsOneWidget,
      );
    });

    testWidgets('show text empty when state is empty', (tester) async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async => ResultGetWordsStorage.right(['banana']),
      );

      // Act
      await tester.pumpWidget(wordsPageApp());
      await tester.pump();

      // Assert
      expect(
        find.byType(Chip),
        findsOneWidget,
      );
    });
  });
}
