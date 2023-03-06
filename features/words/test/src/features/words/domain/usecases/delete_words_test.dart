import 'package:dev_core/dev_core.dart';
import 'package:words/src/core/errors/failure.dart';
import 'package:words/src/core/typedef/signatures.dart';
import 'package:words/src/features/words/domain/interfaces/delete_words_storage_use_case.dart';
import 'package:words/src/features/words/domain/interfaces/words_storage_repository.dart';
import 'package:words/src/features/words/domain/usecases/delete_words.dart';

class WordsStorageRepositoryMock extends Mock implements WordsStorageRepository {}

void main() {
  late WordsStorageRepository repositoryMock;
  late DeleteWordsStorageUseCase useCase;

  setUp(() {
    repositoryMock = WordsStorageRepositoryMock();
    useCase = DeleteWords(repository: repositoryMock);
  });

  group(DeleteWords, () {
    test('return unit when deleteWords', () async {
      // Arrange
      when(() => repositoryMock.deleteWord(value: any(named: 'value'))).thenAnswer(
        (_) async => ResultDeleteWordsStorage.right(unit),
      );

      // Act
      final result = await useCase.call(value: 'value');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        unit,
      );
      verify(() => repositoryMock.deleteWord(value: any(named: 'value'))).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return a WordsDeleteStorageFailure when execute repository', () async {
      // Arrange
      when(() => repositoryMock.deleteWord(value: any(named: 'value'))).thenAnswer(
        (_) async => ResultDeleteWordsStorage.left(WordsDeleteStorageFailure()),
      );

      // Act
      final result = await useCase.call(value: 'value');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<WordsDeleteStorageFailure>(),
      );
      verify(() => repositoryMock.deleteWord(value: any(named: 'value'))).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });
  });
}
