import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/favorite_movie_entity.dart';

part 'movie_list_page_state.freezed.dart';

@freezed
class MovieListPageState with _$MovieListPageState {
  const factory MovieListPageState.loading() = MovieListPageStateLoading;
  const factory MovieListPageState.error({
    required String message,
  }) = MovieListPageStateError;
  const factory MovieListPageState.empty() = MovieListPageStateEmpty;
  const factory MovieListPageState.success({
    required List<FavoriteMovieEntity> favorites,
  }) = MovieListPageStateSuccess;
}
