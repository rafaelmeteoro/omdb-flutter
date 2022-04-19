import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/external/datasource/search_remote_datasource.dart';
import 'package:search/src/infra/datasource/search_remote_datasource_interface.dart';

import '../../mocks/search_movies_response_mock.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dioMock;
  late SearchRemoteDataSourceContract dataSourceContract;

  setUp(() {
    dioMock = DioMock();
    dataSourceContract = SearchRemoteDataSource(dio: dioMock);
  });

  group('Search Remote DataSource', () {
    test(
        'should return ResultSearch when call to http client returns a Response with status code = 200',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: searchMoviesResponseMock,
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await dataSourceContract.searchMovies(title: title);

      // Assert
      expect(result, isA<ResultSearch>());
      verify(() => dioMock.get('/', queryParameters: {'s': title})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test(
        'should throw DataSourceException when call to http service returns a Response with status code != 200',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          data: {'message': 'Title not found'},
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Assert
      expect(() => dataSourceContract.searchMovies(title: title),
          throwsA(isA<DataSourceException>()));
    });

    test(
        'should throw NoInternetException when call to http service throws a DioError with type DioErrorType.connectTimeout',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenThrow(
        DioError(
          type: DioErrorType.connectTimeout,
          requestOptions: RequestOptions(
            path: '/',
          ),
        ),
      );

      // Assert
      expect(() => dataSourceContract.searchMovies(title: title),
          throwsA(isA<NoInternetException>()));
    });

    test(
        'should throw DioError when call to http service throws a DioError with type != DioErrorType.connectTimeout',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: '/',
          ),
        ),
      );

      // Assert
      expect(() => dataSourceContract.searchMovies(title: title),
          throwsA(isA<DioError>()));
    });
  });
}
