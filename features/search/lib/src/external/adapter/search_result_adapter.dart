import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/external/adapter/search_movie_adapter.dart';

class SearchResultAdapter {
  static ResultSearch fromJson(Map<String, dynamic> json) {
    final movies = json['Search'] as List;
    return ResultSearch(
      search: movies.map((map) => SearchMovieAdapter.fromJson(map)).toList(),
      totalResults: json['totalResults'],
      response: json['Response'],
    );
  }
}
