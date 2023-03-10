import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/core/typedef/signatures.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/movie_storage_repository.dart';
import 'package:movie/src/features/movie/domain/interfaces/remove_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/domain/usecases/remove_movie.dart';

class MovieStorageRepositoryMock extends Mock implements MovieStorageRepository {}

void main() {
  late MovieStorageRepository repositoryMock;
  late RemoveMovieStorageUseCase useCase;

  setUp(() {
    repositoryMock = MovieStorageRepositoryMock();
    useCase = RemoveMovie(repository: repositoryMock);
  });

  final movieMock = MovieDetailEntity(
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
    ratings: [],
  );

  group(RemoveMovie, () {
    test('return unit when remove movie', () async {
      // Arrange
      when(() => repositoryMock.removeMovie(movie: movieMock)).thenAnswer(
        (_) async => ResultAddRemoveMovieStorage.right(unit),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        unit,
      );
      verify(() => repositoryMock.removeMovie(movie: movieMock)).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return a MovieAddRemoveStorageFailure when remove movie', () async {
      // Arrange
      when(() => repositoryMock.removeMovie(movie: movieMock)).thenAnswer(
        (_) async => ResultAddRemoveMovieStorage.left(MovieAddRemoveStorageFailure()),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieAddRemoveStorageFailure>(),
      );
      verify(() => repositoryMock.removeMovie(movie: movieMock)).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });
  });
}
