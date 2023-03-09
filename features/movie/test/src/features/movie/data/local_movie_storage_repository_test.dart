import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/data/local_movie_storage_repository.dart';
import 'package:movie/src/features/movie/domain/interfaces/movie_storage_repository.dart';
import 'package:movie_storage_manager/movie_storage_manager.dart';

class MovieStorageMock extends Mock implements MovieStorage {}

void main() {
  late MovieStorage storageMock;
  late MovieStorageRepository localRepository;

  setUp(() {
    storageMock = MovieStorageMock();
    localRepository = LocalMovieStorageRepository(storage: storageMock);
  });

  group(LocalMovieStorageRepository, () {
    test('return ResultContainsMovieStorage.righ when call contains', () async {
      // Arrange
      when(() => storageMock.containsKey(any())).thenAnswer(
        (_) async => true,
      );

      // Act
      final result = await localRepository.contains(key: 'key');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        true,
      );
      verify(() => storageMock.containsKey(any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultContainsMovieStorage.left when storage throw exceptions', () async {
      // Arrange
      when(() => storageMock.containsKey(any())).thenThrow(
        MovieStorageException(message: 'message'),
      );

      // Act
      final result = await localRepository.contains(key: 'key');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieContainsStorageFailure>(),
      );
      verify(() => storageMock.containsKey(any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });
  });
}
