import '../../../../core/typedef/signatures.dart';

abstract class SearchMovieUseCase {
  Future<ResultSearch> call({
    required String query,
  });
}
