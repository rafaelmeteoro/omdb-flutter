import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';
import 'package:omdb_flutter/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:omdb_flutter/app/modules/home/domain/usecases/get_movies.dart';

class HomeMovieRepositoryMock extends Mock implements IHomeMovieRepository {}

final resultSearch = ResultSearch(
  search: [],
  totalResults: "0",
  response: "True",
);

void main() {
  late IHomeMovieRepository homeMovieRepository;
  late IGetMoviesUseCase getMoviesUseCase;

  setUp(() {
    homeMovieRepository = HomeMovieRepositoryMock();
    getMoviesUseCase = GetMoviesUseCase(
      homeMovieRepository: homeMovieRepository,
    );
  });

  group('Get Movies UseCase', () {
    test(
        'should return ResultSearch when call to repository is successfull and when title.lenght > 3',
        () async {
      // Arrange
      const String title = "anything more than 3 caracters";
      when(() => homeMovieRepository.searchMovies(title: title))
          .thenAnswer((_) async => resultSearch);

      // Act
      final result = await getMoviesUseCase.call(title: title);

      // Assert
      expect(result, isA<ResultSearch>());
      verify(() => homeMovieRepository.searchMovies(title: title)).called(1);
      verifyNoMoreInteractions(homeMovieRepository);
    });

    test(
        'should return ResultSearch when call to repository is successfull and when title.lenght = 3',
        () async {
      // Arrange
      const String title = "123";
      when(() => homeMovieRepository.searchMovies(title: title))
          .thenAnswer((_) async => resultSearch);

      // Act
      final result = await getMoviesUseCase.call(title: title);

      // Assert
      expect(result, isA<ResultSearch>());
      verify(() => homeMovieRepository.searchMovies(title: title)).called(1);
      verifyNoMoreInteractions(homeMovieRepository);
    });

    test('should throw HomeShortTitleFailure when title.lenght < 3', () async {
      // Arrange
      const String title = "12";

      // Assert
      expect(() async => await getMoviesUseCase.call(title: title),
          throwsA(isA<HomeShortTitleFailure>()));
      verifyNever(() => homeMovieRepository.searchMovies(title: title));
      verifyNoMoreInteractions(homeMovieRepository);
    });

    test(
        'should throw HomeShortTitleFailure when title.lenght without witespaces < 3',
        () async {
      // Arrange
      const String title = " 1 2 ";

      // Assert
      expect(() async => await getMoviesUseCase.call(title: title),
          throwsA(isA<HomeShortTitleFailure>()));
      verifyNever(() => homeMovieRepository.searchMovies(title: title));
      verifyNoMoreInteractions(homeMovieRepository);
    });
  });
}
