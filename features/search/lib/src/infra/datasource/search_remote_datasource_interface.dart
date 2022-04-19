import 'package:search/src/domain/entities/result_search.dart';

abstract class SearchRemoteDataSourceContract {
  Future<ResultSearch> searchMovies({required String title});
}
