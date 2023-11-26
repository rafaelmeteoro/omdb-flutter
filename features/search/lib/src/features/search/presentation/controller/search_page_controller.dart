import 'package:flutter/material.dart';

import '../../domain/interfaces/search_movie_use_case.dart';
import '../../domain/interfaces/words_storage_use_case.dart';
import 'search_page_state.dart';

class SearchPageController extends ValueNotifier<SearchPageState> {
  SearchPageController({
    required SearchMovieUseCase searchMovieUseCase,
    required WordsStorageUseCase wordsStorageUseCase,
  })  : _searchMovieUseCase = searchMovieUseCase,
        _wordsStorageUseCase = wordsStorageUseCase,
        super(SearchPageStateEmpty());

  final SearchMovieUseCase _searchMovieUseCase;
  final WordsStorageUseCase _wordsStorageUseCase;

  Future<void> searchMovie({required String query}) async {
    value = SearchPageStateLoading();

    final result = await _searchMovieUseCase.call(query: query);

    value = result.fold(
      (failure) => SearchPageStateError(failure.message ?? ''),
      (value) {
        if (value.search.isEmpty) {
          return SearchPageStateEmpty();
        } else {
          _saveQuery(query);
          return SearchPageStateSuccess(value);
        }
      },
    );
  }

  Future<void> _saveQuery(String query) async {
    if (query.isNotEmpty) {
      await _wordsStorageUseCase.call(query: query);
    }
  }
}
