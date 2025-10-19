import 'package:favbet_test_task/features/movies/domain/entities/movies_response_entity.dart';
import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';

class FetchTopRatedUseCase {
  final MoviesRepository repo;
  FetchTopRatedUseCase(this.repo);

  Future<MoviesResponseEntity> call({int page = 1}) {
    if (page < 0) throw Exception('Invalid page');
    return repo.fetchTopRated(page: page);
  }
}
