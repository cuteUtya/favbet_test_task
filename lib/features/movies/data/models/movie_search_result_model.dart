import 'package:favbet_test_task/features/movies/data/models/movie_summary_model.dart';
import 'package:favbet_test_task/features/movies/domain/entities/movie_search_responce_entity.dart';

class MovieSearchResponseModel {
  final int page;
  final List<MovieSummaryModel> results;
  final int totalPages;
  final int totalResults;

  MovieSearchResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieSearchResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieSearchResponseModel(
      page: json['page'] ?? 1,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => MovieSummaryModel.fromJson(e))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
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

  MovieSearchResponceEntity toEntity() {
    return MovieSearchResponceEntity(
      page: page,
      results: results.map((e) => e.toEntity()).toList(),
      totalPages: totalPages,
      totalResults: totalResults,
    );
  }
}
