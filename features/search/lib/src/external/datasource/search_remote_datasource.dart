import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/external/adapter/search_result_adapter.dart';
import 'package:search/src/infra/datasource/search_remote_datasource_interface.dart';

class SearchRemoteDataSource implements SearchRemoteDataSourceContract {
  final Dio _dio;

  SearchRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<ResultSearch> searchMovies({required String title}) async {
    try {
      final Response response = await _dio.get(
        '/',
        queryParameters: {'s': title},
      );

      if (response.statusCode == 200) {
        final responseMap = response.data as Map<String, dynamic>;
        return SearchResultAdapter.fromJson(responseMap);
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
