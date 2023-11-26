sealed class WordsPageState {}

class WordsPageStateEmpty extends WordsPageState {}

class WordsPageStateLoading extends WordsPageState {}

class WordsPageStateError extends WordsPageState {
  WordsPageStateError(this.message);
  final String message;
}

class WordsPageStateSuccess extends WordsPageState {
  WordsPageStateSuccess(this.result);
  final List<String> result;
}
