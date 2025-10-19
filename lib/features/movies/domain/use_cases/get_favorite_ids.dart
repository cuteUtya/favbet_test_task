import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';

class GetFavoriteIdsUseCase {
  final MoviesRepository repo;

  GetFavoriteIdsUseCase(this.repo);

  Future<List<String>> call() {
    return repo.getFavoriteIds();
  }
}
