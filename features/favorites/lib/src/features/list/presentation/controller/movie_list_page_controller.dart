import 'package:flutter/material.dart';

import '../../domain/interfaces/get_movies_use_case.dart';
import 'movie_list_page_state.dart';

class MovieListPageController extends ValueNotifier<MovieListPageState> {
  MovieListPageController({
    required GetMoviesUseCase useCase,
  })  : _useCase = useCase,
        super(MovieListPageStateLoading());

  final GetMoviesUseCase _useCase;

  Future<void> loadFavorites() async {
    value = MovieListPageStateLoading();

    final result = await _useCase();

    value = result.fold(
      (failure) => MovieListPageStateError(failure.message ?? ''),
      (value) {
        if (value.isEmpty) {
          return MovieListPageStateEmpty();
        }
        return MovieListPageStateSuccess(value);
      },
    );
  }
}
