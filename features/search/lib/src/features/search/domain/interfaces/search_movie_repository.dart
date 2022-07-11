import '../../../../core/typedef/signatures.dart';

abstract class SearchMovieRepository {
  Future<ResultSearch> call({
    required String title,
  });
}
