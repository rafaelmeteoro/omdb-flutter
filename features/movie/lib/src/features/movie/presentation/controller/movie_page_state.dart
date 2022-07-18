import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/movie_detail_entity.dart';

part 'movie_page_state.freezed.dart';

@freezed
class MoviePageState with _$MoviePageState {
  const factory MoviePageState.loading() = MoviePageStateLoading;
  const factory MoviePageState.error({
    required String message,
  }) = MoviePageStateError;
  const factory MoviePageState.success({
    required MovieDetailEntity movie,
  }) = MoviePageStateSuccess;
}
