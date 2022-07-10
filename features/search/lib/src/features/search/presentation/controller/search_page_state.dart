import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/result_search_entity.dart';

part 'search_page_state.freezed.dart';

@freezed
class SearchPageState with _$SearchPageState {
  const factory SearchPageState.empty() = SearchPageStateEmpty;
  const factory SearchPageState.loading() = SearchPageStateLoading;
  const factory SearchPageState.error({
    required String message,
  }) = SearchPageStateError;
  const factory SearchPageState.success({
    required ResultSearchEntity result,
  }) = SearchPageStateSuccess;
}
