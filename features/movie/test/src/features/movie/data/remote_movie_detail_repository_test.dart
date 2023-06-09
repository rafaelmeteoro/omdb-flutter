import 'package:app_core/app_core.dart';
import 'package:core/domain.dart';
import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/data/remote_movie_detail_repository.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';

import '../../../mocks/movie_detail_response_mock.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dioMock;
  late RemoteMovieDetailRepository remoteRepository;

  setUp(() {
    dioMock = DioMock();
    remoteRepository = RemoteMovieDetailRepository(dio: dioMock);
  });

  group(RemoteMovieDetailRepository, () {
    test('should return MovieDetail.right when call to http client return a Response with status code = 200', () async {
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
      final result = await remoteRepository.call(id: id);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieDetailEntity>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'i': id})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test('should return ServerFailure when call to http client return a Response with status code != 200', () async {
      // Arrange
      const id = '1234';
      when(() => dioMock.get('/', queryParameters: {'i': id})).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          data: {'message': 'Movie not found'},
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(id: id);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ServerFailure>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'i': id})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test('should return ServerFailure when call to http client throws a DioError type DioErrorType.connectTimeout',
        () async {
      // Arrange
      const id = '1234';
      when(() => dioMock.get('/', queryParameters: {'i': id})).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(id: id);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ServerFailure>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'i': id})).called(1);
      verifyNoMoreInteractions(dioMock);
    });

    test('should return ServerFailure when call to http client throws a DioError type != DioErrorType.connectTimeout',
        () async {
      // Arrange
      const id = '1234';
      when(() => dioMock.get('/', queryParameters: {'i': id})).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      // Act
      final result = await remoteRepository.call(id: id);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieDetailFailure>(),
      );
      verify(() => dioMock.get('/', queryParameters: {'i': id})).called(1);
      verifyNoMoreInteractions(dioMock);
    });
  });
}
