import 'package:dev_core/dev_core.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/core/typedef/signatures.dart';
import 'package:search/src/features/search/domain/interfaces/words_storage_repository.dart';
import 'package:search/src/features/search/domain/interfaces/words_storage_use_case.dart';
import 'package:search/src/features/search/domain/usecases/save_query.dart';

class WordsStorageRepositoryMock extends Mock implements WordsStorageRepository {}

void main() {
  late WordsStorageRepository repositoryMock;
  late WordsStorageUseCase useCase;

  setUp(() {
    repositoryMock = WordsStorageRepositoryMock();
    useCase = SaveQuery(repository: repositoryMock);
  });

  group(WordsStorageUseCase, () {
    test('return unit when execute repository', () async {
      // Arrange
      when(() => repositoryMock.call(word: any(named: 'word'))).thenAnswer(
        (_) async => ResultWordsStorage.right(unit),
      );

      // Act
      final result = await useCase.call(query: 'query');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        unit,
      );
      verify(() => repositoryMock.call(word: any(named: 'word'))).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return a WordsStorageFailure when execute repository', () async {
      // Arrange
      when(() => repositoryMock.call(word: any(named: 'word'))).thenAnswer(
        (_) async => ResultWordsStorage.left(WordsStorageFailure()),
      );

      // Act
      final result = await useCase.call(query: 'query');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<WordsStorageFailure>(),
      );
      verify(() => repositoryMock.call(word: any(named: 'word'))).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });
  });
}
