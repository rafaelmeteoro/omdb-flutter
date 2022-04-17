import 'package:dio/dio.dart';
import 'package:omdb_flutter/app/core/exceptions.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/external/adapter/home_entity_adapter.dart';
import 'package:omdb_flutter/app/modules/home/infra/datasources/home_remote_datasource_interface.dart';

class HomeRemoteDatasource implements IHomeRemoteDatasource {
  final Dio _dio;

  HomeRemoteDatasource({
    required dio,
  }) : _dio = dio;

  @override
  Future<ResultSearch> getResult({required String title}) async {
    try {
      final Response response = await _dio.get(
        '/',
        queryParameters: {'s': title},
      );

      if (response.statusCode == 200) {
        final responseMap = response.data as Map<String, dynamic>;
        final resultSearch =
            HomeMovieEntityAdapter.fromMapRoot(map: responseMap);
        return resultSearch;
      } else {
        throw DataSourceException(message: response.data['message'] ?? '');
      }
    } on DioError catch (error, stackTrace) {
      if (error.type == DioErrorType.connectTimeout) {
        throw NoInternetException(
          message: 'No Internet connection. Try Again',
          stackTrace: stackTrace,
        );
      } else {
        rethrow;
      }
    }
  }
}
