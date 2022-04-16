import 'package:omdb_flutter/app/core/exceptions.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';
import 'package:omdb_flutter/app/modules/home/domain/repositories/home_repository_interface.dart';
import 'package:omdb_flutter/app/modules/home/infra/datasources/home_remote_datasource_interface.dart';

class HomeMovieRepository implements IHomeMovieRepository {
  final IHomeRemoteDatasource _homeRemoteDatasource;

  HomeMovieRepository({
    required IHomeRemoteDatasource homeRemoteDatasource,
  }) : _homeRemoteDatasource = homeRemoteDatasource;

  @override
  Future<ResultSearch> searchMovies({required String title}) async {
    try {
      return await _homeRemoteDatasource.getResult(title: title);
    } on CustomException catch (error, stackTrace) {
      throw HomeDataSourceFailure(
        message: error.message,
        stackTrace: stackTrace,
        label: 'HomeMovieRepository: searchMovies() - HomeDataSourceFailure',
      );
    } on TypeError catch (error, stackTrace) {
      throw HomeParseFailure(
        message: 'Erro inesperado. Por favor tente novamente.',
        stackTrace: stackTrace,
        label: 'HomeMovieRepository: searchMovies() - HomeParseFailure',
      );
    } on FormatException catch (error, stackTrace) {
      throw HomeParseFailure(
        message: 'Erro inesperado. Por favor tente novamente.',
        stackTrace: stackTrace,
        label: 'HomeMovieRepository: searchMovies() - HomeParseFailure',
      );
    } catch (error, stackTrace) {
      throw HomeUnknownFailure(
        message: 'Erro inesperado. Por favor tente novamente.',
        stackTrace: stackTrace,
        label: 'HomeMovieRepository: searchMovies() - HomeUnknownFailure',
      );
    }
  }
}
