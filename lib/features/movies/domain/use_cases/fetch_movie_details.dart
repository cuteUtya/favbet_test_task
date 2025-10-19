import 'package:favbet_test_task/features/movies/domain/entities/movie_details_entity.dart';
import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';

class FetchMovieDetailsUseCase {
  final MoviesRepository repo;

  FetchMovieDetailsUseCase(this.repo);

  Future<MovieDetailsEntity> call(String id) async {
    return repo.fetchMovieDetails(id);
  }
}
