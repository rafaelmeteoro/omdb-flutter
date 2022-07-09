import '../../../../core/typdef/signatures.dart';

abstract class SearchMovieRepository {
  Future<ResultSearch> call({
    required String title,
  });
}
