import 'package:core/domain.dart';

abstract class MovieEvent extends Equatable {}

class GetMovieDetail extends MovieEvent {
  final String id;

  GetMovieDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
