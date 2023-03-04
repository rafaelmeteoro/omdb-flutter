import 'package:dev_core/dev_core.dart';
import 'package:words/src/core/errors/failure.dart';
import 'package:words/src/features/words/data/local_words_storage_repository.dart';
import 'package:words/src/features/words/domain/interfaces/words_storage_repository.dart';
import 'package:words_storage_manager/words_storage_manager.dart';

class WordsStorageMock extends Mock implements WordsStorage {}

void main() {
  late WordsStorage storageMock;
  late WordsStorageRepository localRepository;

  setUp(() {
    storageMock = WordsStorageMock();
    localRepository = LocalWordsStorageRepository(storage: storageMock);
  });

  group(LocalWordsStorageRepository, () {
    test('return ResultWordsGetStorage.righ with empty list', () async {
      // Arrange
      when(() => storageMock.read(any())).thenAnswer(
        (_) async => [],
      );

      // Act
      final result = await localRepository.getWords();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        [],
      );
      verify(() => storageMock.read(any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultWordsGetStorage.right with list words', () async {
      // Arrange
      when(() => storageMock.read(any())).thenAnswer(
        (_) async => ['banana', 'maça', 'mamão'],
      );

      // Act
      final result = await localRepository.getWords();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        ['banana', 'maça', 'mamão'],
      );
      verify(() => storageMock.read(any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultWordsGetStorage.left when storage throw exception', () async {
      // Arrange
      when(() => storageMock.read(any())).thenThrow(
        WordsStorageException(message: 'message'),
      );

      // Act
      final result = await localRepository.getWords();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<WordsGetStorageFailure>(),
      );
      verify(() => storageMock.read(any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });
  });
}
