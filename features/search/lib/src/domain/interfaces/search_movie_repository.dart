import 'package:core/core.dart';

import '../entities/result_search_entity.dart';
import '../errors/failures.dart';

abstract class SearchMovieRepository {
  Future<Either<SearchFailure, ResultSearchEntity>> call({
    required String title,
  });
}
