import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/contains_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_detail_content_controller.dart';

class ContainsMovieStorageUseCaseMock extends Mock implements ContainsMovieStorageUseCase {}

void main() {
  late ContainsMovieStorageUseCase useCase;
  late MovieDetailContentController controller;

  setUp(() {
    useCase = ContainsMovieStorageUseCaseMock();
    controller = MovieDetailContentController(containsMovieStorageUseCase: useCase);
  });

  group(MovieDetailContentController, () {
    test('return satte false when create', () async {
      // Assert
      expect(controller.value, false);
    });

    test('return state true when usecase return', () async {
      // Arrange
      final movieDetailEntity = MovieDetailEntity(
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
      when(() => useCase.call(movie: movieDetailEntity)).thenAnswer((_) async => right(true));

      // Act
      await controller.toggleFavorite(movieDetailEntity);

      // Assert
      expect(controller.value, true);
    });

    test('return state false when usecase return failure', () async {
      // Arrange
      final movieDetailEntity = MovieDetailEntity(
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
      when(() => useCase.call(movie: movieDetailEntity)).thenAnswer(
        (_) async => left(MovieContainsStorageFailure()),
      );

      // Act
      await controller.toggleFavorite(movieDetailEntity);

      // Assert
      expect(controller.value, false);
    });
  });
}
