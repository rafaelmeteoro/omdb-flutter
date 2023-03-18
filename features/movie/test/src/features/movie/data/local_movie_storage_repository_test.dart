import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/data/local_movie_storage_repository.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';
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

  final movieEntity = MovieDetailEntity(
    title: 'title',
    year: 'year',
    rated: 'rated',
    released: 'released',
    runtime: 'runtime',
    genre: ['genre'],
    director: ['director'],
    writer: ['writer'],
    actors: ['actors'],
    plot: 'plot',
    language: ['language'],
    country: ['country'],
    awards: 'awards',
    poster: 'poster',
    metascore: 'metascore',
    imdbRating: 'imdbRating',
    imdbVotes: 'imdbVotes',
    imdbId: 'imdbId',
    type: 'type',
    ratings: [
      RatingEntity(
        source: 'source',
        value: 'value',
      ),
    ],
  );

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

    test('return ResultAddRemoveMovieStorage.right when add movie', () async {
      // Arrang

      when(() => storageMock.put(any(), any())).thenAnswer(
        (_) async => unit,
      );

      // Act
      final result = await localRepository.addMovie(movie: movieEntity);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        unit,
      );
      verify(() => storageMock.put(any(), any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultAddRemoveMovieStorage.left when storage throw exception', () async {
      // Arrange
      when(() => storageMock.put(any(), any())).thenThrow(
        MovieStorageException(message: 'message'),
      );

      // Act
      final result = await localRepository.addMovie(movie: movieEntity);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieAddRemoveStorageFailure>(),
      );
      verify(() => storageMock.put(any(), any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultAddRemoveMovieStorage.right when remove movie', () async {
      // Arrange
      when(() => storageMock.delete(any())).thenAnswer(
        (_) async => unit,
      );

      // Act
      final result = await localRepository.removeMovie(movie: movieEntity);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        unit,
      );
      verify(() => storageMock.delete(any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultAddRemoveMovieStorage.left when storage throw exception', () async {
      // Arrange
      when(() => storageMock.delete(any())).thenThrow(
        MovieStorageException(message: 'message'),
      );

      // Act
      final result = await localRepository.removeMovie(movie: movieEntity);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieAddRemoveStorageFailure>(),
      );
      verify(() => storageMock.delete(any())).called(1);
      verifyNoMoreInteractions(storageMock);
    });
  });
}
