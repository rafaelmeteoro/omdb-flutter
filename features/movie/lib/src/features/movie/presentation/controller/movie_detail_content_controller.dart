import 'package:flutter/material.dart';

import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/interfaces/contains_movie_storage_use_case.dart';

class MovieDetailContentController extends ValueNotifier<bool> {
  MovieDetailContentController({
    required ContainsMovieStorageUseCase containsMovieStorageUseCase,
  })  : _containsMovieStorageUseCase = containsMovieStorageUseCase,
        super(false);

  final ContainsMovieStorageUseCase _containsMovieStorageUseCase;

  Future<void> toggleFavorite(MovieDetailEntity movie) async {
    final result = await _containsMovieStorageUseCase.call(movie: movie);

    value = result.fold(
      (failure) => false,
      (value) => value,
    );
  }
}
