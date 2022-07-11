import '../../../../core/typedef/signatures.dart';
import '../interfaces/get_movie_detail_use_case.dart';
import '../interfaces/movie_detail_repository.dart';

class GetMovieDetail implements GetMovieDetailUseCase {
  final MovieDetailRepository _repository;

  GetMovieDetail({
    required MovieDetailRepository repository,
  }) : _repository = repository;

  @override
  Future<MovieDetail> call({required String id}) {
    return _repository.call(id: id);
  }
}
