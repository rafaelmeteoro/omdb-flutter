import 'package:freezed_annotation/freezed_annotation.dart';

part 'words_page_state.freezed.dart';

@freezed
class WordsPageState with _$WordsPageState {
  const factory WordsPageState.empty() = WordsPageStateEmpty;
  const factory WordsPageState.loading() = WordsPageStateLoading;
  const factory WordsPageState.error({
    required String message,
  }) = WordsPageStateError;
  const factory WordsPageState.success({
    required List<String> result,
  }) = WordsPageStateSuccess;
}
