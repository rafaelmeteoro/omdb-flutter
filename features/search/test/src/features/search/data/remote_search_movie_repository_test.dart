import 'package:app_core/failures.dart';
import 'package:core/domain.dart';
import 'package:dev_core/dev_core.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/features/search/data/remote_search_movie_repository.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';

import '../../../mocks/search_movies_response_broken_mock.dart';
import '../../../mocks/search_movies_response_mock.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dioMock;
  late RemoteSearchMovieRepository remoteRepository;

  setUp(() {
    dioMock = DioMock();
    remoteRepository = RemoteSearchMovieRepository(dio: dioMock);
  });

  group(RemoteSearchMovieRepository, () {
    test('should return ResultSearch.right when call to http client returns a Response with status code = 200',
        () async {
      // Arrange
      const title = '12345';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: searchMoviesResponseMock,
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(title: title);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ResultSearchEntity>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'s': title})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test(
        'should return ServerFailure when call to http client returns a Response with status code = 200 and json broken',
        () async {
      // Arrange
      const title = '12345';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          data: searchMoviesResponseBrokenMock,
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(title: title);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ServerFailure>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'s': title})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test('should return ServerFailure when call to http client returns a Response with status code != 200', () async {
      // Arrange
      const title = '12345';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          data: {'message': 'Title not found'},
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(title: title);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ServerFailure>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'s': title})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test('should return ServerFailure when call to http client throws a DioError with type DioErrorType.connectTimeout',
        () async {
      // Arrange
      const title = '12345';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenThrow(
        DioError(
          type: DioErrorType.connectionTimeout,
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(title: title);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ServerFailure>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'s': title})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test(
        'should return ResultSearchFailure when call to http client throws a DioError with type != DioErrorType.connectTimeout',
        () async {
      // Arrange
      const title = '12345';
      when(() => dioMock.get('/', queryParameters: {'s': title})).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(title: title);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ResultSearchFailure>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'s': title})).called(1);
      verifyNoMoreInteractions(dioMock);
    });
  });
}
