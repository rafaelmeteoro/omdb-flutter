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
        super(const SearchPageState.empty());

  final SearchMovieUseCase _searchMovieUseCase;
  final WordsStorageUseCase _wordsStorageUseCase;

  Future<void> searchMovie({required String query}) async {
    value = const SearchPageState.loading();

    await _wordsStorageUseCase.call(query: query);
    final result = await _searchMovieUseCase.call(query: query);

    value = result.fold(
      (failure) => SearchPageState.error(message: failure.message ?? ''),
      (value) {
        return value.search.isEmpty ? const SearchPageState.empty() : SearchPageState.success(result: value);
      },
    );
  }
}
