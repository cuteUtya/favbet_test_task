import 'package:favbet_test_task/features/movies/domain/entities/movie_summary_entity.dart';

class MovieSummaryModel {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final bool adult;
  final bool video;
  final double popularity;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;

  MovieSummaryModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.video,
    required this.popularity,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
  });

  factory MovieSummaryModel.fromJson(Map<String, dynamic> json) {
    return MovieSummaryModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      adult: json['adult'] ?? false,
      video: json['video'] ?? false,
      popularity: (json['popularity'] ?? 0).toDouble(),
      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': adult,
      'video': video,
      'popularity': popularity,
      'genre_ids': genreIds,
      'original_language': originalLanguage,
      'original_title': originalTitle,
    };
  }

  MovieSummaryEntity toEntity() {
    return MovieSummaryEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      adult: adult,
      video: video,
      popularity: popularity,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
    );
  }
}
