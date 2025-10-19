import 'package:favbet_test_task/features/movies/domain/entities/movie_search_responce_entity.dart';
import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';

class SearchMoviesUseCase {
  final MoviesRepository repo;
  SearchMoviesUseCase(this.repo);

  Future<MovieSearchResponceEntity> call(String q, {int page = 0}) {
    if (page < 0) throw Exception('Invalid page');
    return repo.search(q, page: page);
  }
}
