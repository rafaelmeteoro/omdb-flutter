import '../../domain/entities/result_search_entity.dart';

sealed class SearchPageState {}

class SearchPageStateEmpty extends SearchPageState {}

class SearchPageStateLoading extends SearchPageState {}

class SearchPageStateError extends SearchPageState {
  SearchPageStateError(this.message);
  final String message;
}

class SearchPageStateSuccess extends SearchPageState {
  SearchPageStateSuccess(this.result);
  final ResultSearchEntity result;
}
