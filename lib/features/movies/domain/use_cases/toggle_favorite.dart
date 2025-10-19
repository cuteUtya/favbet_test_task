import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';

class ToggleFavoriteUseCase {
  final MoviesRepository repo;

  ToggleFavoriteUseCase(this.repo);

  Future<void> call(String movieId) async {
    await repo.toggleFavorite(movieId);
  }
}
