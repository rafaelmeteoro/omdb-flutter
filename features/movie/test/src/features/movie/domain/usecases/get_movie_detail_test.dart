import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/typedef/signatures.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/get_movie_detail_use_case.dart';
import 'package:movie/src/features/movie/domain/interfaces/movie_detail_repository.dart';
import 'package:movie/src/features/movie/domain/usecases/get_movie_detail.dart';

class MovieDetailRepositoryMock extends Mock implements MovieDetailRepository {}

const ratings = [
  RatingEntity(
    source: 'source',
    value: 'value',
  )
];

const movieDetail = MovieDetailEntity(
  title: 'title',
  year: 'year',
  rated: 'rated',
  released: 'released',
  runtime: 'runtime',
  genre: ['genre'],
  director: ['director'],
  writer: ['wirter'],
  actors: ['actors'],
  plot: 'plot',
  language: ['language'],
  country: ['country'],
  awards: 'awards',
  poster: 'poster',
  metascore: 'metascore',
  imdbRating: 'imdbRating',
  imdbVotes: 'imdbVotes',
  imdbId: 'imdbId',
  type: 'type',
  ratings: ratings,
);

void main() {
  late MovieDetailRepository repository;
  late GetMovieDetailUseCase useCase;

  setUp(() {
    repository = MovieDetailRepositoryMock();
    useCase = GetMovieDetail(repository: repository);
  });

  group(GetMovieDetail, () {
    test('should return MovieDetailEntity when repository is successfull',
        () async {
      // Arrange
      when(() => repository.call(id: any(named: 'id')))
          .thenAnswer((_) async => MovieDetail.right(movieDetail));

      // Act
      final result = await useCase.call(id: 'id');

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        equals(movieDetail),
      );
      verify(() => repository.call(id: any(named: 'id'))).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
