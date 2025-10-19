import 'package:favbet_test_task/features/movies/domain/entities/movie_details_entity.dart';
import 'package:favbet_test_task/features/movies/domain/entities/movie_search_responce_entity.dart';
import 'package:favbet_test_task/features/movies/domain/entities/movies_response_entity.dart';

abstract class MoviesRepository {
  Future<MoviesResponseEntity> fetchTopRated({int page = 1});
  Future<MovieDetailsEntity> fetchMovieDetails(String id);
  Future<MovieSearchResponceEntity> search(String q, {int page = 1});
  Future<bool> isFavorite(String movieId);
  Future<void> toggleFavorite(String movieId);
}
