import 'package:dev_core/dev_core.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/features/search/data/local_words_storage_repository.dart';
import 'package:search/src/features/search/domain/interfaces/words_storage_repository.dart';
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
    test('return ResultWordsStorage.right when put in storage', () async {
      // Arrange
      when(() => storageMock.put(any(), any())).thenAnswer(
        (_) async => Future.value(unit),
      );

      // Act
      final result = await localRepository.call(word: 'word');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<Unit>(),
      );
      verify(() => storageMock.put(any(), any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return WordsStorageFailure when storage throw exception', () async {
      // Arrange
      when(() => storageMock.put(any(), any())).thenThrow(
        WordsStorageException(message: 'message'),
      );

      // Act
      final result = await localRepository.call(word: 'word');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<WordsStorageFailure>(),
      );
      verify(() => storageMock.put(any(), any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });
  });
}
