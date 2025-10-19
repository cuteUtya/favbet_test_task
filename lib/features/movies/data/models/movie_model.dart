import 'package:favbet_test_task/features/movies/domain/entities/movie_entity.dart';

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double rating;
  final int voteCount;
  final List<GenreModel> genres;
  final int runtime;
  final String status;
  final String tagline;
  final String originalLanguage;
  final int budget;
  final int revenue;
  final String homepage;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.rating,
    required this.voteCount,
    required this.genres,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.originalLanguage,
    required this.budget,
    required this.revenue,
    required this.homepage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e))
          .toList(),
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      budget: json['budget'] ?? 0,
      revenue: json['revenue'] ?? 0,
      homepage: json['homepage'] ?? '',
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
      'vote_average': rating,
      'vote_count': voteCount,
      'genres': genres.map((e) => e.toJson()).toList(),
      'runtime': runtime,
      'status': status,
      'tagline': tagline,
      'original_language': originalLanguage,
      'budget': budget,
      'revenue': revenue,
      'homepage': homepage,
    };
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      rating: rating,
      voteCount: voteCount,
      genres: genres.map((e) => e.name).toList(),
      runtime: runtime,
      status: status,
      tagline: tagline,
      originalLanguage: originalLanguage,
      budget: budget,
      revenue: revenue,
      homepage: homepage,
    );
  }
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'], name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
