import 'package:dev_core/dev_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/presentation/controller/search_page_controller.dart';
import 'package:search/src/features/search/presentation/controller/search_page_state.dart';

class SearchMovieUseCaseMock extends Mock implements SearchMovieUseCase {}

void main() {
  late SearchMovieUseCase useCase;
  late SearchPageController controller;

  setUp(() {
    useCase = SearchMovieUseCaseMock();
    controller = SearchPageController(searchMovieUseCase: useCase);
  });

  group('Search Page Controller', () {
    test('should return state SearchPageStateEmpty when create', () async {
      // Assert
      expect(controller.value, isA<SearchPageStateEmpty>());
    });

    test(
        'should return state SearchPageStateSuccess when usecase return result',
        () async {
      // Arrange
      final resultEntity = ResultSearchEntity(
        search: [
          MovieEntity(
            imdbId: 'imdbId',
            title: 'title',
            year: 'year',
            type: 'type',
            poster: 'poster',
          )
        ],
        totalResults: '0',
        response: 'True',
      );
      when(() => useCase.call(query: 'query')).thenAnswer(
        (_) async => right(resultEntity),
      );

      // Act
      await controller.searchMovie(query: 'query');

      // Assert
      expect(controller.value, isA<SearchPageStateSuccess>());
    });

    test('should return state SearchPageStateEmpty when usecase return empty',
        () async {
      // Arrange
      final resultEntity = ResultSearchEntity(
        search: [],
        totalResults: '0',
        response: 'True',
      );
      when(() => useCase.call(query: 'query')).thenAnswer(
        (_) async => right(resultEntity),
      );

      // Act
      await controller.searchMovie(query: 'query');

      // Assert
      expect(controller.value, isA<SearchPageStateEmpty>());
    });

    test('should return state SearchPageStateError when usecase return failure',
        () async {
      // Arrange
      when(() => useCase.call(query: 'query')).thenAnswer(
        (_) async => left(ShortTitleFailure()),
      );

      // Act
      await controller.searchMovie(query: 'query');

      // Assert
      expect(controller.value, isA<SearchPageStateError>());
    });
  });
}
