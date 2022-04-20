import 'package:core/core.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/errors/failures.dart';
import 'package:movie/src/domain/repositories/movie_detail_repository_interface.dart';

abstract class GetMovieDetailUseCaseContract {
  Future<Either<MovieFailure, MovieDetail>> execute({required String id});
}

class GetMovieDetailUseCase implements GetMovieDetailUseCaseContract {
  final MovieDetailRepositoryContract _movieDetailRepository;

  GetMovieDetailUseCase({
    required MovieDetailRepositoryContract movieDetailRepository,
  }) : _movieDetailRepository = movieDetailRepository;

  @override
  Future<Either<MovieFailure, MovieDetail>> execute({
    required String id,
  }) async {
    return await _movieDetailRepository.getMovieDetail(id: id);
  }
}
