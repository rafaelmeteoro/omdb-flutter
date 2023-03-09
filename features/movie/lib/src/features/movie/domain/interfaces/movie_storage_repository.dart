import '../../../../core/typedef/signatures.dart';

abstract class MovieStorageRepository {
  Future<ResultContainsMovieStorage> contains({
    required String key,
  });
}
