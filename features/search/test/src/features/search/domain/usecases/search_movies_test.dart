import 'package:dev_core/dev_core.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/core/typedef/signatures.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_repository.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/domain/usecases/search_movies.dart';

class SearchMovieRepositoryMock extends Mock implements SearchMovieRepository {}

const movieMock = MovieEntity(
  imdbId: 'imdbId',
  title: 'title',
  year: 'year',
  type: 'type',
  poster: 'poster',
);

const searchMock = ResultSearchEntity(
  search: [movieMock],
  totalResults: '0',
  response: 'True',
);

void main() {
  late SearchMovieRepository repository;
  late SearchMovieUseCase useCase;

  setUp(() {
    repository = SearchMovieRepositoryMock();
    useCase = SearchMovie(repository: repository);
  });

  group(SearchMovieUseCase, () {
    test('should return ResultSearchEntity when execute to repository is successfull and when query.lenght > 3',
        () async {
      // Arrange
      const String query = 'anything more than 3 characters';
      when(() => repository.call(title: query)).thenAnswer((_) async => ResultSearch.right(searchMock));

      // Act
      final result = await useCase.call(query: query);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        searchMock,
      );
      verify(() => repository.call(title: query)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return ResultSearchEntity when execute to repository is successfull and when query.lenght = 3',
        () async {
      // Arrange
      const String query = '123';
      when(() => repository.call(title: query)).thenAnswer((_) async => ResultSearch.right(searchMock));

      // Act
      final result = await useCase.call(query: query);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        searchMock,
      );
      verify(() => repository.call(title: query)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return ShortTitleFailure when query.lenght < 3', () async {
      // Arrange
      const String query = '12';

      // Act
      final result = await useCase.call(query: query);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ShortTitleFailure>(),
      );
      verifyNever(() => repository.call(title: query));
      verifyNoMoreInteractions(repository);
    });
  });
}
