import 'package:dev_core/dev_core.dart';
import 'package:words/src/core/errors/failure.dart';
import 'package:words/src/features/words/domain/interfaces/delete_words_storage_use_case.dart';
import 'package:words/src/features/words/domain/interfaces/get_words_storage_use_case.dart';
import 'package:words/src/features/words/presentation/controller/words_page_controller.dart';
import 'package:words/src/features/words/presentation/controller/words_page_state.dart';

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

  group(WordsPageController, () {
    test('return state WordsPageStateEmpty when create', () async {
      // Assert
      expect(controller.value, isA<WordsPageStateEmpty>());
    });

    test('return state WordsPageStateSuccess when usecase return result', () async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async => right(['banana', 'maça', 'mamão']),
      );

      // Act
      await controller.getWords();

      // Assert
      expect(controller.value, isA<WordsPageStateSuccess>());
      verify(() => getWordsStorageUseCaseMock.call()).called(1);
      verifyNever(() => deleteWordsStorageUseCaseMock.call(value: any(named: 'value')));
    });

    test('return state WordsPageStateEmpty when usecase return empty', () async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async => right([]),
      );

      // Act
      await controller.getWords();

      // Assert
      expect(controller.value, isA<WordsPageStateEmpty>());
      verify(() => getWordsStorageUseCaseMock.call()).called(1);
      verifyNever(() => deleteWordsStorageUseCaseMock.call(value: any(named: 'value')));
    });

    test('return state WordsPageStateError when usecase return failure', () async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async => left(WordsGetStorageFailure()),
      );

      // Act
      await controller.getWords();

      // Assert
      expect(controller.value, isA<WordsPageStateError>());
      verify(() => getWordsStorageUseCaseMock.call()).called(1);
      verifyNever(() => deleteWordsStorageUseCaseMock.call(value: any(named: 'value')));
    });

    test('return state WordsPageStateSuccess when usecase delete words return unit', () async {
      // Arrange
      when(() => getWordsStorageUseCaseMock.call()).thenAnswer(
        (_) async => right(['banana']),
      );
      when(() => deleteWordsStorageUseCaseMock.call(value: any(named: 'value'))).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await controller.deleteWord(word: 'word');

      // Assert
      expect(
        controller.value,
        isA<WordsPageStateSuccess>(),
      );
      verify(() => deleteWordsStorageUseCaseMock.call(value: any(named: 'value'))).called(1);
      verify(() => getWordsStorageUseCaseMock.call()).called(1);
      verifyNoMoreInteractions(deleteWordsStorageUseCaseMock);
      verifyNoMoreInteractions(getWordsStorageUseCaseMock);
    });
  });
}
