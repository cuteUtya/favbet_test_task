import 'package:favbet_test_task/features/movies/domain/entities/movie_summary_entity.dart';

class MoviesResponseEntity {
  final int page;
  final List<MovieSummaryEntity> results;
  final int totalPages;
  final int totalResults;

  const MoviesResponseEntity({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}
