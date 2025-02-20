import 'package:popcornhub/data/domain/entity/movie_detail_entity.dart';


class MovieDetailModel extends MovieDetailEntity {
  final bool? adult;
  final dynamic belongsToCollection; // Changed from Null to dynamic
  final int? budget;
  final List<Genres>? genres;
  final String? homepage;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final double? popularity;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final bool? video;
  final int? voteCount;

  const MovieDetailModel({
    this.adult,
    required super.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    required super.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    required super.overview,
    this.popularity,
    required super.posterPath,
    this.productionCompanies,
    this.productionCountries,
    required super.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    required super.title,
    this.video,
    required super.voteAverage,
    this.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      adult: json['adult'],
      backdropPath: json['backdrop_path'] ?? '',
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'],
      genres: (json['genres'] as List?)?.map((v) => Genres.fromJson(v)).toList(),
      homepage: json['homepage'],
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'],
      originCountry: (json['origin_country'] as List?)?.map((v) => v as String).toList(),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] ?? '',
      productionCompanies: (json['production_companies'] as List?)
          ?.map((v) => ProductionCompanies.fromJson(v))
          .toList(),
      productionCountries: (json['production_countries'] as List?)
          ?.map((v) => ProductionCountries.fromJson(v))
          .toList(),
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List?)
          ?.map((v) => SpokenLanguages.fromJson(v))
          .toList(),
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'] ?? 'Unknown',
      video: json['video'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection,
      'budget': budget,
      'genres': genres?.map((v) => v.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies?.map((v) => v.toJson()).toList(),
      'production_countries': productionCountries?.map((v) => v.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages?.map((v) => v.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    }..removeWhere((key, value) => value == null);
  }
}

class Genres {
  final int? id;
  final String? name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ProductionCompanies {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) {
    return ProductionCompanies(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }
}

class ProductionCountries {
  final String? iso31661;
  final String? name;

  ProductionCountries({this.iso31661, this.name});

  factory ProductionCountries.fromJson(Map<String, dynamic> json) {
    return ProductionCountries(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso31661,
      'name': name,
    };
  }
}

class SpokenLanguages {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) {
    return SpokenLanguages(
      englishName: json['english_name'],
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english_name': englishName,
      'iso_639_1': iso6391,
      'name': name,
    };
  }
}
