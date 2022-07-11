import 'package:movie/src/core/typedef/signatures.dart';

abstract class MovieDetailRepository {
  Future<MovieDetail> call({
    required String id,
  });
}
