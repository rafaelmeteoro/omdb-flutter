import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:omdb_flutter/app/core/exceptions.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';
import 'package:omdb_flutter/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:omdb_flutter/app/modules/home/infra/datasources/home_remote_datasource_interface.dart';
import 'package:omdb_flutter/app/modules/home/infra/repositories/home_repository.dart';

class HomeRemoteDataSourceMock extends Mock implements IHomeRemoteDatasource {}

final homeMovie = HomeMovieEntity(
  imdbId: 'imdbId',
  title: 'title',
  year: 'year',
  type: 'type',
  poster: 'poster',
);

final resultSearch = ResultSearch(
  search: [homeMovie],
  totalResults: '0',
  response: 'True',
);

void main() {
  late IHomeRemoteDatasource homeRemoteDatasource;
  late IHomeMovieRepository homeMovieRepository;

  setUp(() {
    homeRemoteDatasource = HomeRemoteDataSourceMock();
    homeMovieRepository = HomeMovieRepository(
      homeRemoteDatasource: homeRemoteDatasource,
    );
  });

  group('Get Remote Movies DataSource', () {
    test(
        'should return result search when call remote datasource is successfull',
        () async {
      // Arrange
      when(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .thenAnswer(
        (_) async => resultSearch,
      );

      // Act
      final result = await homeMovieRepository.searchMovies(title: 'text');

      // Assert
      expect(result, isA<ResultSearch>());
      expect(result.search, isA<List<HomeMovieEntity>>());
      verify(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(homeRemoteDatasource);
    });

    test(
        'should throw HomeDataSourceFailure when datasource throws a subclass of CustomException',
        () async {
      // Arrange
      when(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .thenThrow(DataSourceException(message: ''));

      // Assert
      expect(() async => await homeMovieRepository.searchMovies(title: ''),
          throwsA(isA<HomeDataSourceFailure>()));
      verify(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(homeRemoteDatasource);
    });

    test('should throw HomeParseFailure when datasource throws a TypeError',
        () async {
      // Arrange
      when(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .thenThrow(TypeError());

      // Assert
      expect(() async => await homeMovieRepository.searchMovies(title: ''),
          throwsA(isA<HomeParseFailure>()));
      verify(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(homeRemoteDatasource);
    });

    test(
        'should throw HomeParseFailure when datasource throws a FormatException',
        () async {
      // Arrange
      when(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .thenThrow(const FormatException());

      // Assert
      expect(() async => await homeMovieRepository.searchMovies(title: ''),
          throwsA(isA<HomeParseFailure>()));
      verify(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(homeRemoteDatasource);
    });

    test('should throw HomeUnknownFailure when datasource throws a Exception',
        () async {
      // Arrange
      when(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .thenThrow(Exception());

      // Assert
      expect(() async => await homeMovieRepository.searchMovies(title: ''),
          throwsA(isA<HomeUnknownFailure>()));
      verify(() => homeRemoteDatasource.getResult(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(homeRemoteDatasource);
    });
  });
}
