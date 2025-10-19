import 'package:favbet_test_task/features/movies/data/models/movie_summary_model.dart';

import '../../domain/entities/movies_response_entity.dart';

class MoviesResponseModel {
  final int page;
  final List<MovieSummaryModel> results;
  final int totalPages;
  final int totalResults;

  const MoviesResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponseModel.fromJson(Map<String, dynamic> json) {
    return MoviesResponseModel(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  MoviesResponseEntity toEntity() {
    return MoviesResponseEntity(
      page: page,
      results: results.map((e) => e.toEntity()).toList(),
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
