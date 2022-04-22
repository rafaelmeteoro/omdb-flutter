import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/external/datasource/movie_detail_remote_datasource.dart';
import 'package:movie/src/infra/datasource/movie_detail_remote_datasource_interface.dart';

import '../../mocks/movie_detail_response_mock.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dioMock;
  late MovieDetailRemoteDataSourceContract dataSourceContract;

  setUp(() {
    dioMock = DioMock();
    dataSourceContract = MovieDetailRemoteDataSource(dio: dioMock);
  });

  group('MovieDetail Remote DataSource', () {
    test(
        'should return MovieDetail when call to http client returns a Response with status code = 200',
        () async {
      // Arrange
      const id = '1234';
      when(() => dioMock.get('/', queryParameters: {'i': id})).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: movieDetailResponseMock,
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await dataSourceContract.getMovieDetail(id: id);

      // Assert
      expect(result, isA<MovieDetail>());
      verify(() => dioMock.get('/', queryParameters: {'i': id})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test(
        'should throw DataSourceException when call to http client returns a Response with status code != 200',
        () async {
      // Arrange
      const id = '1234';
      when(() => dioMock.get('/', queryParameters: {'i': id})).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          data: {'message': 'Title not fount'},
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Assert
      expect(() => dataSourceContract.getMovieDetail(id: id),
          throwsA(isA<DataSourceException>()));
    });

    test(
        'should throw NoInternetException when call to http client throws a DioError with type DioErrorType.connectTimeout',
        () async {
      // Arrange
      const id = '1234';
      when(() => dioMock.get('/', queryParameters: {'i': id})).thenThrow(
        DioError(
          type: DioErrorType.connectTimeout,
          requestOptions: RequestOptions(
            path: '/',
          ),
        ),
      );

      // Assert
      expect(() => dataSourceContract.getMovieDetail(id: id),
          throwsA(isA<NoInternetException>()));
    });

    test(
        'should throw DioError when call to http service throws a DioError with type != DioErrorType.connectTimeout',
        () async {
      // Arrange
      const id = '1234';
      when(() => dioMock.get('/', queryParameters: {'i': id})).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: '/',
          ),
        ),
      );

      // Assert
      expect(() => dataSourceContract.getMovieDetail(id: id),
          throwsA(isA<DioError>()));
    });
  });
}
