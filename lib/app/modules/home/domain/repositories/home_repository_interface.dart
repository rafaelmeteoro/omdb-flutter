import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';

abstract class IHomeMovieRepository {
  Future<ResultSearch> searchMovies({
    required String title,
  });
}
