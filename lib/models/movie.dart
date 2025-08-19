class Movie{
  int id;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  List<int>? genreVector;
  List<String>? genres;
  int? budget;
  String? homepage;
  String? imdbId;
  List<String>? originCountry;
  int? runtime;
  String? tagline;

  Movie({
    required this.id,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.genreVector,
    this.genres,
    this.budget,
    this.homepage,
    this.imdbId,
    this.originCountry,
    this.runtime,
    this.tagline
  });

  // Factory constructor
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : null,
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
      genreVector: json['genre_vector'] != null ? List<int>.from(json['genre_vector']) : null,
      genres: json['genreNames'] != null
          ? List<String>.from(json['genreNames'].map((g) => g.toString()))
          : null,
      budget: json['budget'],
      homepage: json['homepage'],
      imdbId: json['imdb_id'],
      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'].map((g) => g.toString()))
          : null,
      runtime: json['runtime'],
      tagline: json['tagline']
    );
  }
}