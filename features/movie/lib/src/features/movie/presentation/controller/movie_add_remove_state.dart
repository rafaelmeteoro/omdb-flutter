import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/movie_detail_entity.dart';

part 'movie_add_remove_state.freezed.dart';

@freezed
class MovieAddRemoveState with _$MovieAddRemoveState {
  const factory MovieAddRemoveState.initial() = MovieAddRemoveStateInitial;
  const factory MovieAddRemoveState.success({
    required MovieDetailEntity movie,
  }) = MovieAddRemoveStateSuccess;
  const factory MovieAddRemoveState.error({
    required String message,
  }) = MovieAddRemoveStateError;
}
