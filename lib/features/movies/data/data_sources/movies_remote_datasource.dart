import 'package:dio/dio.dart';

import 'package:favbet_test_task/env.dart';
import 'package:favbet_test_task/features/movies/data/models/movie_details_model.dart';
import 'package:favbet_test_task/features/movies/data/models/movie_search_result_model.dart';
import 'package:favbet_test_task/features/movies/data/models/movies_response_model.dart';
import 'package:favbet_test_task/features/movies/domain/data_sources/movies_remote_datasource.dart';

class MoviesRemoteDatasourceImpl extends MoviesRemoteDatasource {
  Dio dio;

  MoviesRemoteDatasourceImpl(this.dio);

  @override
  Future<MoviesResponseModel> fetchTopRated({required int page}) async {
    final res = await dio.get('$movieApiHost/movie/top_rated?page=$page');
    return MoviesResponseModel.fromJson(res.data);
  }

  @override
  Future<MovieDetailsModel> fetchMovieDetails(String id) async {
    final res = await dio.get('$movieApiHost/movie/$id');
    return MovieDetailsModel.fromJson(res.data);
  }

  @override
  Future<MovieSearchResponseModel> search({
    required String q,
    required int page,
  }) async {
    final res = await dio.get(
      '$movieApiHost/search/movie',
      queryParameters: {'query': q, 'page': page},
    );

    return MovieSearchResponseModel.fromJson(res.data);
  }
}
