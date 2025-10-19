class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double rating;
  final int voteCount;
  final List<String> genres;
  final int runtime;
  final String status;
  final String tagline;
  final String originalLanguage;
  final int budget;
  final int revenue;
  final String homepage;

  const MovieEntity({
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
}
