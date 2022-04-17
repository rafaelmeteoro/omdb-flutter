abstract class HomeEvent {}

class SearchMoviesEvent implements HomeEvent {
  final String searchText;

  SearchMoviesEvent({
    required this.searchText,
  });
}
