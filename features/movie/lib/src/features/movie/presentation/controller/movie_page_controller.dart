import 'package:flutter/material.dart';

import '../../domain/interfaces/get_movie_detail_use_case.dart';
import 'movie_page_state.dart';

class MoviePageController extends ValueNotifier<MoviePageState> {
  MoviePageController({
    required GetMovieDetailUseCase getMovieDetailUseCase,
  })  : _getMovieDetailUseCase = getMovieDetailUseCase,
        super(MoviePageStateLoading());

  final GetMovieDetailUseCase _getMovieDetailUseCase;

  Future<void> getMovieDetail({required String id}) async {
    value = MoviePageStateLoading();

    final result = await _getMovieDetailUseCase.call(id: id);

    value = result.fold(
      (failure) => MoviePageStateError(failure.message ?? ''),
      MoviePageStateSuccess.new,
    );
  }
}
