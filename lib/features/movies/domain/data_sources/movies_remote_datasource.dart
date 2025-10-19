import 'package:favbet_test_task/features/movies/data/models/movie_details_model.dart';
import 'package:favbet_test_task/features/movies/data/models/movie_search_result_model.dart';
import 'package:favbet_test_task/features/movies/data/models/movies_response_model.dart';

abstract class MoviesRemoteDatasource {
  Future<MoviesResponseModel> fetchTopRated({required int page});
  Future<MovieDetailsModel> fetchMovieDetails(String id);
  Future<MovieSearchResponseModel> search({
    required String q,
    required int page,
  });
}
