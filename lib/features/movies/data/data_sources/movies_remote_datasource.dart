import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:favbet_test_task/env.dart';
import 'package:favbet_test_task/features/movies/data/models/movie_details_model.dart';
import 'package:favbet_test_task/features/movies/data/models/movie_search_result_model.dart';
import 'package:favbet_test_task/features/movies/data/models/movies_response_model.dart';

class MoviesRemoteDatasource {
  final _dio = Dio();

  Future<MoviesResponseModel> fetchTopRated({required int page}) async {
    final res = await _dio.get('$movieApiHost/movie/top_rated&page=$page');
    return MoviesResponseModel.fromJson(jsonDecode(res.data));
  }

  Future<MovieDetailsModel> fetchMovieDetails(String id) async {
    final res = await _dio.get('$movieApiHost/movie/$id');
    return MovieDetailsModel.fromJson(jsonDecode(res.data));
  }

  Future<MovieSearchResponseModel> search({
    required String q,
    required int page,
  }) async {
    final res = await _dio.get(
      '$movieApiHost/search/movie?query=$q&page=$page',
    );

    return MovieSearchResponseModel.fromJson(jsonDecode(res.data));
  }
}
