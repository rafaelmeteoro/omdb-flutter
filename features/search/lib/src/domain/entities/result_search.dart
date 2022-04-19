import 'package:equatable/equatable.dart';
import 'package:search/src/domain/entities/movie.dart';

class ResultSearch extends Equatable {
  final List<Movie> search;
  final String totalResults;
  final String? response;

  const ResultSearch({
    required this.search,
    required this.totalResults,
    this.response,
  });

  @override
  List<Object?> get props => [
        search,
        totalResults,
        response,
      ];
}
