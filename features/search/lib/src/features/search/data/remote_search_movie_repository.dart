import 'package:app_core/app_core.dart';
import 'package:core/domain.dart';

import '../../../core/errors/failure.dart';
import '../../../core/typedef/signatures.dart';
import '../domain/interfaces/search_movie_repository.dart';
import 'dto/result_search_dto.dart';

class RemoteSearchMovieRepository implements SearchMovieRepository {
  RemoteSearchMovieRepository({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<ResultSearch> call({required String title}) async {
    try {
      final response = await _dio.get(
        '/',
        queryParameters: {'s': title},
      );

      if (response.statusCode == 200) {
        final responseMap = response.data as JsonFormat;
        final resultDto = ResultSearchDto.fromJson(responseMap);
        if (resultDto.response == 'False') {
          return ResultSearch.left(
            const ServerFailure(message: 'Filme não encontrado'),
          );
        } else {
          return ResultSearch.right(resultDto);
        }
      } else {
        final responseMap = response.data as JsonFormat;
        return ResultSearch.left(
          ServerFailure(message: responseMap['message']),
        );
      }
    } on DioException catch (error, stackTrace) {
      if (error.type == DioExceptionType.connectionTimeout) {
        return ResultSearch.left(
          const ServerFailure(message: 'No internet connection. Try again.'),
        );
      } else {
        return ResultSearch.left(
          ResultSearchFailure(message: stackTrace.toString()),
        );
      }
    }
  }
}
