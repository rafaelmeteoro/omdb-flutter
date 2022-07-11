import '../../../../core/typedef/signatures.dart';

abstract class GetMovieDetailUseCase {
  Future<MovieDetail> call({
    required String id,
  });
}
