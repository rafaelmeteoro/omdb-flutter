import '../../domain/entities/result_search_entity.dart';

abstract class SearchRemoteDataSourceContract {
  Future<ResultSearchEntity> searchMovies({required String title});
}
