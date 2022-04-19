import 'package:dartz/dartz.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/domain/errors/failures.dart';

abstract class SearchMovieRepositoryContract {
  Future<Either<SearchFailure, ResultSearch>> searchMovies({
    required String title,
  });
}
