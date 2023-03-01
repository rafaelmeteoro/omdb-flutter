import 'package:flutter/material.dart';

import '../../domain/interfaces/get_movie_detail_use_case.dart';
import 'movie_page_state.dart';

class MoviePageController extends ValueNotifier<MoviePageState> {
  MoviePageController({
    required GetMovieDetailUseCase getMovieDetailUseCase,
  })  : _getMovieDetailUseCase = getMovieDetailUseCase,
        super(const MoviePageState.loading());

  final GetMovieDetailUseCase _getMovieDetailUseCase;

  Future<void> getMovieDetail({required String id}) async {
    value = const MoviePageState.loading();

    final result = await _getMovieDetailUseCase.call(id: id);

    value = result.fold(
      (failure) => MoviePageState.error(message: failure.message ?? ''),
      (value) => MoviePageState.success(movie: value),
    );
  }
}
