import 'package:core/domain.dart';

import 'movie_entity.dart';

class ResultSearchEntity extends Equatable {
  final List<MovieEntity> search;
  final String? totalResults;
  final String response;

  const ResultSearchEntity({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  @override
  List<Object?> get props => [
        search,
        totalResults,
        response,
      ];
}
