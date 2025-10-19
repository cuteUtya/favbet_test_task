import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';

class IsFavoriteUseCase {
  final MoviesRepository repo;

  IsFavoriteUseCase(this.repo);

  Future<bool> call(String movieId) {
    return repo.isFavorite(movieId);
  }
}
