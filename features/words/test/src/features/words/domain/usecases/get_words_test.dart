import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:words/src/core/errors/failure.dart';
import 'package:words/src/core/typedef/signatures.dart';
import 'package:words/src/features/words/domain/interfaces/get_words_storage_use_case.dart';
import 'package:words/src/features/words/domain/interfaces/words_storage_repository.dart';
import 'package:words/src/features/words/domain/usecases/get_words.dart';

class WordsStorageRepositoryMock extends Mock implements WordsStorageRepository {}

void main() {
  late WordsStorageRepository repositoryMock;
  late GetWordsStorageUseCase useCase;

  setUp(() {
    repositoryMock = WordsStorageRepositoryMock();
    useCase = GetWords(repository: repositoryMock);
  });

  group(GetWords, () {
    test('return list of words when getWords', () async {
      // Arrange
      when(() => repositoryMock.getWords()).thenAnswer(
        (_) async => ResultGetWordsStorage.right(['banana', 'maça', 'mamão']),
      );

      // Act
      final result = await useCase.call();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        ['banana', 'maça', 'mamão'],
      );
      verify(() => repositoryMock.getWords()).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return a WordsGetSotrageFailure when execute repository', () async {
      // Arrange
      when(() => repositoryMock.getWords()).thenAnswer(
        (_) async => ResultGetWordsStorage.left(WordsGetStorageFailure()),
      );

      // Act
      final result = await useCase.call();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<WordsGetStorageFailure>(),
      );
      verify(() => repositoryMock.getWords()).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });
  });
}
