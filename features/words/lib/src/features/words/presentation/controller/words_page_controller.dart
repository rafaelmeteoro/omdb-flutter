import 'package:flutter/material.dart';

import '../../domain/interfaces/delete_words_storage_use_case.dart';
import '../../domain/interfaces/get_words_storage_use_case.dart';
import 'words_page_state.dart';

class WordsPageController extends ValueNotifier<WordsPageState> {
  WordsPageController({
    required GetWordsStorageUseCase getWordsStorageUseCase,
    required DeleteWordsStorageUseCase deleteWordsStorageUseCase,
  })  : _getWordsStorageUseCase = getWordsStorageUseCase,
        _deleteWordsStorageUseCase = deleteWordsStorageUseCase,
        super(const WordsPageState.empty());

  final GetWordsStorageUseCase _getWordsStorageUseCase;
  final DeleteWordsStorageUseCase _deleteWordsStorageUseCase;

  Future<void> getWords() async {
    value = const WordsPageState.loading();

    final result = await _getWordsStorageUseCase.call();

    value = result.fold(
      (failure) => WordsPageState.error(message: failure.message ?? ''),
      (value) => value.isEmpty ? const WordsPageState.empty() : WordsPageStateSuccess(result: value),
    );
  }

  Future<void> deleteWord({required String word}) async {
    value = const WordsPageState.loading();
    await _deleteWordsStorageUseCase.call(value: word);
    await getWords();
  }
}
