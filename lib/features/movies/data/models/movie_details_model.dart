import 'package:favbet_test_task/features/movies/domain/entities/movie_details_entity.dart';

class MovieDetailsModel {
  final bool adult;
  final String backdropPath;
  final int? belongsToCollection;
  final int budget;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompanyModel> productionCompanies;
  final List<ProductionCountryModel> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailsModel({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      belongsToCollection: json['belongs_to_collection']?['id'],
      budget: json['budget'] ?? 0,
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreModel.fromJson(e))
              .toList() ??
          [],
      homepage: json['homepage'] ?? '',
      id: json['id'],
      imdbId: json['imdb_id'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      productionCompanies:
          (json['production_companies'] as List<dynamic>?)
              ?.map((e) => ProductionCompanyModel.fromJson(e))
              .toList() ??
          [],
      productionCountries:
          (json['production_countries'] as List<dynamic>?)
              ?.map((e) => ProductionCountryModel.fromJson(e))
              .toList() ??
          [],
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages:
          (json['spoken_languages'] as List<dynamic>?)
              ?.map((e) => SpokenLanguageModel.fromJson(e))
              .toList() ??
          [],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection,
      'budget': budget,
      'genres': genres.map((e) => e.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies
          .map((e) => e.toJson())
          .toList(),
      'production_countries': productionCountries
          .map((e) => e.toJson())
          .toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages.map((e) => e.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      rating: voteAverage,
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

// Вложенные модели
class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'], name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class ProductionCompanyModel {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompanyModel({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'],
      name: json['name'] ?? '',
      logoPath: json['logo_path'],
      originCountry: json['origin_country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_path': logoPath,
    'origin_country': originCountry,
  };
}

class ProductionCountryModel {
  final String iso;
  final String name;

  ProductionCountryModel({required this.iso, required this.name});

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountryModel(
      iso: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'iso_3166_1': iso, 'name': name};
}

class SpokenLanguageModel {
  final String englishName;
  final String iso;
  final String name;

  SpokenLanguageModel({
    required this.englishName,
    required this.iso,
    required this.name,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageModel(
      englishName: json['english_name'] ?? '',
      iso: json['iso_639_1'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'english_name': englishName,
    'iso_639_1': iso,
    'name': name,
  };
}
