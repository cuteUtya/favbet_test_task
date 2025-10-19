class MovieSummaryEntity {
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

  MovieSummaryEntity({
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
}
