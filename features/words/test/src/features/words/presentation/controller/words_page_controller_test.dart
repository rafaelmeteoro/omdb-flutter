import 'package:dev_core/dev_core.dart';
import 'package:words/src/core/errors/failure.dart';
import 'package:words/src/features/words/domain/interfaces/get_words_storage_use_case.dart';
import 'package:words/src/features/words/presentation/controller/words_page_controller.dart';
import 'package:words/src/features/words/presentation/controller/words_page_state.dart';

class GetWordsStorageUseCaseMock extends Mock implements GetWordsStorageUseCase {}

void main() {
  late GetWordsStorageUseCase getWordsStorageUseCaseMock;
  late WordsPageController controller;

  setUp(() {
    getWordsStorageUseCaseMock = GetWordsStorageUseCaseMock();
    controller = WordsPageController(
      getWordsStorageUseCase: getWordsStorageUseCaseMock,
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
      verifyInOrder(
        [
          () => WordsPageState.empty,
          () => WordsPageState.loading,
          () => WordsPageState.success,
        ],
      );
      verify(() => getWordsStorageUseCaseMock.call()).called(1);
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
      verifyInOrder(
        [
          () => WordsPageState.empty,
          () => WordsPageState.loading,
          () => WordsPageState.empty,
        ],
      );
      verify(() => getWordsStorageUseCaseMock.call()).called(1);
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
      verifyInOrder(
        [
          () => WordsPageState.empty,
          () => WordsPageState.loading,
          () => WordsPageState.error,
        ],
      );
      verify(() => getWordsStorageUseCaseMock.call()).called(1);
    });
  });
}
