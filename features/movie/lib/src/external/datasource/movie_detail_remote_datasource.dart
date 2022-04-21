import 'package:core/core.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/external/adapter/movie_detail_adapter.dart';
import 'package:movie/src/infra/datasource/movie_detail_remote_datasource_interface.dart';

class MovieDetailRemoteDataSource
    implements MovieDetailRemoteDataSourceContract {
  final Dio _dio;

  MovieDetailRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<MovieDetail> getMovieDetail({required String id}) async {
    try {
      final Response response = await _dio.get(
        '/',
        queryParameters: {'i': id},
      );

      if (response.statusCode == 200) {
        final responseMap = response.data as Map<String, dynamic>;
        return MovieDetailAdapter.fromJson(responseMap);
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
