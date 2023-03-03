import 'package:app_core/app_core.dart';
import 'package:core/domain.dart';

import '../../../core/errors/failure.dart';
import '../../../core/typedef/signatures.dart';
import '../domain/interfaces/movie_detail_repository.dart';
import 'dto/movie_detail_dto.dart';

class RemoteMovieDetailRepository implements MovieDetailRepository {
  RemoteMovieDetailRepository({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<MovieDetail> call({required String id}) async {
    try {
      final response = await _dio.get(
        '/',
        queryParameters: {'i': id},
      );

      if (response.statusCode == 200) {
        final responseMap = response.data as JsonFormat;
        final movieDetailDto = MovieDetailDto.fromJson(responseMap);
        return MovieDetail.right(movieDetailDto);
      } else {
        final responseMap = response.data as JsonFormat;
        return MovieDetail.left(
          ServerFailure(message: responseMap['message']),
        );
      }
    } on DioError catch (error, stackStrace) {
      if (error.type == DioErrorType.connectionTimeout) {
        return MovieDetail.left(
          const ServerFailure(message: 'No internet connection. Try again.'),
        );
      } else {
        return MovieDetail.left(
          MovieDetailFailure(message: stackStrace.toString()),
        );
      }
    }
  }
}
