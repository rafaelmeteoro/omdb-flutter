import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';

class HomeMovieEntityAdapter {
  static HomeMovieEntity fromMap({required Map<String, dynamic> map}) {
    return HomeMovieEntity(
      imdbId: map['imdbID'],
      title: map['Title'],
      year: map['Year'],
      type: map['Type'],
      poster: map['Poster'],
    );
  }

  static ResultSearch fromMapRoot({required Map<String, dynamic> map}) {
    final movieList = map['Search'] as List;
    return ResultSearch(
      search: movieList.map((map) => fromMap(map: map)).toList(),
      totalResults: map['totalResults'],
      response: map['Response'],
    );
  }
}
