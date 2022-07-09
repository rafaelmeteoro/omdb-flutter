import 'package:core/domain.dart';
import 'package:search/src/features/search/data/dto/result_search_dto.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/infra/datasource/search_remote_datasource_interface.dart';

class SearchRemoteDataSource implements SearchRemoteDataSourceContract {
  final Dio _dio;

  SearchRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<ResultSearchEntity> searchMovies({required String title}) async {
    try {
      final Response response = await _dio.get(
        '/',
        queryParameters: {'s': title},
      );

      if (response.statusCode == 200) {
        final responseMap = response.data as Map<String, dynamic>;
        return ResultSearchDto.fromJson(responseMap);
      } else {
        throw DataSourceException(message: response.data['message'] ?? '');
      }
    } on DioError catch (error, stackTrace) {
      if (error.type == DioErrorType.connectTimeout) {
        throw NoInternetException(
          message: 'No internet connection. Try again.',
          stackTrace: stackTrace,
        );
      } else {
        rethrow;
      }
    }
  }
}
