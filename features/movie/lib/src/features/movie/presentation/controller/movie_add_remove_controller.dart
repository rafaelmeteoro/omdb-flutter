import 'package:flutter/material.dart';

import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/interfaces/add_remove_movie_storage_use_case.dart';
import 'movie_add_remove_state.dart';

class MovieAddRemoveController extends ValueNotifier<MovieAddRemoveState> {
  MovieAddRemoveController({
    required AddRemoveMovieStorageUseCase useCase,
  })  : _useCase = useCase,
        super(MovieAddRemoveStateInitial());

  final AddRemoveMovieStorageUseCase _useCase;

  Future<void> addOrRemove({required MovieDetailEntity movie}) async {
    final result = await _useCase.call(movie: movie);

    value = result.fold(
      (failure) => MovieAddRemoveStateError(failure.message ?? ''),
      (value) => MovieAddRemoveStateSuccess(movie),
    );
  }
}
