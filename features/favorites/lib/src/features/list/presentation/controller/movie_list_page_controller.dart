import 'package:flutter/material.dart';

import '../../domain/interfaces/get_movies_use_case.dart';
import 'movie_list_page_state.dart';

class MovieListPageController extends ValueNotifier<MovieListPageState> {
  MovieListPageController({
    required GetMoviesUseCase useCase,
  })  : _useCase = useCase,
        super(const MovieListPageState.loading());

  final GetMoviesUseCase _useCase;

  Future<void> loadFavorites() async {
    value = const MovieListPageState.loading();

    final result = await _useCase();

    value = result.fold(
      (failure) => MovieListPageState.error(message: failure.message ?? ''),
      (value) {
        if (value.isEmpty) {
          return const MovieListPageState.empty();
        }
        return MovieListPageState.success(favorites: value);
      },
    );
  }
}
