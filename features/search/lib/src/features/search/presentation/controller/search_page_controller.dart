import 'package:flutter/material.dart';

import '../../domain/interfaces/search_movie_use_case.dart';
import 'search_page_state.dart';

class SearchPageController extends ValueNotifier<SearchPageState> {
  final SearchMovieUseCase _searchMovieUseCase;

  SearchPageController({
    required SearchMovieUseCase searchMovieUseCase,
  })  : _searchMovieUseCase = searchMovieUseCase,
        super(const SearchPageState.empty());

  Future<void> searchMovie({required String query}) async {
    value = const SearchPageState.loading();

    final result = await _searchMovieUseCase.call(query: query);

    value = result.fold((failure) {
      return SearchPageState.error(message: failure.message ?? '');
    }, (value) {
      return value.search.isEmpty
          ? const SearchPageState.empty()
          : SearchPageState.success(result: value);
    });
  }
}
