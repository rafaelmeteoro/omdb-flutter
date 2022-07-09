import 'package:app_core/app_core.dart';
import 'package:core/domain.dart';
import 'package:search/src/core/errors/failure.dart';
import 'package:search/src/core/typdef/signatures.dart';
import 'package:search/src/features/search/data/dto/result_search_dto.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_repository.dart';

class RemoteSearchMovieRepository implements SearchMovieRepository {
  final Dio _dio;

  RemoteSearchMovieRepository({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<ResultSearch> call({required String title}) async {
    try {
      final Response response = await _dio.get(
        '/',
        queryParameters: {'s': title},
      );

      if (response.statusCode == 200) {
        final responseMap = response.data as JsonFormat;
        final resultDto = ResultSearchDto.fromJson(responseMap);
        return ResultSearch.right(resultDto);
      } else {
        return ResultSearch.left(
          ServerFailure(message: response.data['message']),
        );
      }
    } on DioError catch (error, stackTrace) {
      if (error.type == DioErrorType.connectTimeout) {
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
