import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/get_movie_detail_use_case.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_page_controller.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_page_state.dart';

class MovieDetailUseCaseMock extends Mock implements GetMovieDetailUseCase {}

void main() {
  late GetMovieDetailUseCase useCase;
  late MoviePageController controller;

  setUp(() {
    useCase = MovieDetailUseCaseMock();
    controller = MoviePageController(getMovieDetailUseCase: useCase);
  });

  group(MoviePageController, () {
    test('should return state MoviePageStateLoading when create', () async {
      // Assert
      expect(controller.value, isA<MoviePageStateLoading>());
    });

    test('should return state MoviePageStateSuccess when usecase return movie detail', () async {
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
      when(() => useCase.call(id: 'id')).thenAnswer((_) async => right(movieDetailEntity));

      // Act
      await controller.getMovieDetail(id: 'id');

      // Assert
      expect(controller.value, isA<MoviePageStateSuccess>());
    });

    test('should return state MoviePageStateError when usecase return failure', () async {
      // Arrange
      when(() => useCase.call(id: 'id')).thenAnswer((_) async => left(MovieDetailFailure()));

      // Act
      await controller.getMovieDetail(id: 'id');

      // Assert
      expect(controller.value, isA<MoviePageStateError>());
    });
  });
}
