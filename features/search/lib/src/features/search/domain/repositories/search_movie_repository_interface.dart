import 'package:core/domain.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';

import 'package:search/src/features/search/domain/errors/failures.dart';

abstract class SearchMovieRepositoryContract {
  Future<Either<SearchFailure, ResultSearchEntity>> searchMovies({
    required String title,
  });
}
