import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';
import 'package:omdb_flutter/app/modules/home/domain/repositories/home_repository_interface.dart';

abstract class IGetMoviesUseCase {
  Future<ResultSearch> call({
    required String title,
  });
}

class GetMoviesUseCase implements IGetMoviesUseCase {
  final IHomeMovieRepository _homeMovieRepository;

  GetMoviesUseCase({
    required IHomeMovieRepository homeMovieRepository,
  }) : _homeMovieRepository = homeMovieRepository;

  @override
  Future<ResultSearch> call({required String title}) async {
    final bool isShortString = title.replaceAll(' ', '').length < 3;
    if (isShortString) {
      throw HomeShortTitleFailure(
        message: 'Search title mus be more than 3 characters.',
      );
    }
    return await _homeMovieRepository.searchMovies(title: title);
  }
}
