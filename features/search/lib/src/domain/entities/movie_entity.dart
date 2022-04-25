import 'package:core/core.dart';

class MovieEntity extends Equatable {
  final String imdbId;
  final String title;
  final String year;
  final String type;
  final String poster;

  const MovieEntity({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.type,
    required this.poster,
  });

  @override
  List<Object?> get props => [
        imdbId,
        title,
        year,
        type,
        poster,
      ];
}
