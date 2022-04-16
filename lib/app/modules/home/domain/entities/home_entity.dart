class HomeMovieEntity {
  final String imdbId;
  final String title;
  final String year;
  final String type;
  final String poster;

  HomeMovieEntity({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.type,
    required this.poster,
  });
}

class ResultSearch {
  final List<HomeMovieEntity> search;
  final String totalResults;
  final String? response;

  ResultSearch({
    required this.search,
    required this.totalResults,
    this.response,
  });
}
