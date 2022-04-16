import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:omdb_flutter/app/core/exceptions.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/external/datasources/home_remote_datasource.dart';
import 'package:omdb_flutter/app/modules/home/infra/datasources/home_remote_datasource_interface.dart';

import '../../mocks/get_movies_response_mock.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dioMock;
  late IHomeRemoteDatasource homeRemoteDatasource;

  setUp(() {
    dioMock = DioMock();
    homeRemoteDatasource = HomeRemoteDatasource(dio: dioMock);
  });

  group('Home Remote Datasource', () {
    test(
        'should return ResultSearch when call to http client returns a Response with status code = 200',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('https://www.omdbapi.com/?apikey=1abc75a6',
          queryParameters: {'s': title})).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: getMoviesResponseMock,
          requestOptions:
              RequestOptions(path: 'https://www.omdbapi.com/?apikey=1abc75a6'),
        ),
      );

      // Act
      final result = await homeRemoteDatasource.getResult(title: title);

      // Assert
      expect(result, isA<ResultSearch>());
      verify(() => dioMock.get('https://www.omdbapi.com/?apikey=1abc75a6',
          queryParameters: {'s': title})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test(
        'should throw DatasourceException when call to http service returns a Response with status code != 200',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('https://www.omdbapi.com/?apikey=1abc75a6',
          queryParameters: {'s': title})).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          data: {'message': 'Title not found'},
          requestOptions:
              RequestOptions(path: 'https://www.omdbapi.com/?apikey=1abc75a6'),
        ),
      );

      // Assert
      expect(() => homeRemoteDatasource.getResult(title: title),
          throwsA(isA<DataSourceException>()));
    });

    test(
        'should throw NoInternetException when call to http service throws a DioError with type DioErrorType.connectTimeout',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('https://www.omdbapi.com/?apikey=1abc75a6',
          queryParameters: {'s': title})).thenThrow(
        DioError(
          type: DioErrorType.connectTimeout,
          requestOptions: RequestOptions(
            path: 'https://www.omdbapi.com/?apikey=1abc75a6',
          ),
        ),
      );

      // Assert
      expect(() => homeRemoteDatasource.getResult(title: title),
          throwsA(isA<NoInternetException>()));
    });

    test(
        'should throw DioError when call to http service throws a DioError with type != DioErrorType.connectTimeout',
        () async {
      // Arrange
      const title = '123456';
      when(() => dioMock.get('https://www.omdbapi.com/?apikey=1abc75a6',
          queryParameters: {'s': title})).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: 'https://www.omdbapi.com/?apikey=1abc75a6',
          ),
        ),
      );

      // Assert
      expect(() => homeRemoteDatasource.getResult(title: title),
          throwsA(isA<DioError>()));
    });
  });
}
