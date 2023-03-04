import 'package:dev_core/dev_core.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/domain/interfaces/words_storage_use_case.dart';
import 'package:search/src/features/search/presentation/controller/search_page_controller.dart';
import 'package:search/src/features/search/presentation/controller/search_page_state.dart';

class SearchMovieUseCaseMock extends Mock implements SearchMovieUseCase {}

class WordsStorageUseCaseMock extends Mock implements WordsStorageUseCase {}

void main() {
  late SearchMovieUseCase searchUseCaseMock;
  late WordsStorageUseCase wordsStorageUseCaseMock;
  late SearchPageController controller;

  setUp(() {
    searchUseCaseMock = SearchMovieUseCaseMock();
    wordsStorageUseCaseMock = WordsStorageUseCaseMock();
    controller = SearchPageController(
      searchMovieUseCase: searchUseCaseMock,
      wordsStorageUseCase: wordsStorageUseCaseMock,
    );
  });

  group(SearchPageController, () {
    test('should return state SearchPageStateEmpty when create', () async {
      // Assert
      expect(controller.value, isA<SearchPageStateEmpty>());
    });

    test('should return state SearchPageStateSuccess when usecase return result', () async {
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
      when(() => searchUseCaseMock.call(query: 'query')).thenAnswer(
        (_) async => right(resultEntity),
      );
      when(() => wordsStorageUseCaseMock.call(query: 'query')).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await controller.searchMovie(query: 'query');

      // Assert
      expect(controller.value, isA<SearchPageStateSuccess>());
      verify(() => searchUseCaseMock.call(query: 'query')).called(1);
      verify(() => wordsStorageUseCaseMock.call(query: 'query')).called(1);
    });

    test('should return state SearchPageStateEmpty when usecase return empty', () async {
      // Arrange
      final resultEntity = ResultSearchEntity(
        search: [],
        totalResults: '0',
        response: 'True',
      );
      when(() => searchUseCaseMock.call(query: 'query')).thenAnswer(
        (_) async => right(resultEntity),
      );
      when(() => wordsStorageUseCaseMock.call(query: 'query')).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await controller.searchMovie(query: 'query');

      // Assert
      expect(controller.value, isA<SearchPageStateEmpty>());
      verify(() => searchUseCaseMock.call(query: 'query')).called(1);
      verify(() => wordsStorageUseCaseMock.call(query: 'query')).called(1);
    });

    test('should return state SearchPageStateError when usecase return failure', () async {
      // Arrange
      when(() => searchUseCaseMock.call(query: 'query')).thenAnswer(
        (_) async => left(ShortTitleFailure()),
      );
      when(() => wordsStorageUseCaseMock.call(query: 'query')).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await controller.searchMovie(query: 'query');

      // Assert
      expect(controller.value, isA<SearchPageStateError>());
      verify(() => searchUseCaseMock.call(query: 'query')).called(1);
      verify(() => wordsStorageUseCaseMock.call(query: 'query')).called(1);
    });
  });
}
