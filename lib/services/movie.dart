class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final String language;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  // final List<int> budgets;
  // final List<int> revenues;
  // final String originCountry;
  // final String status;
  // final dynamic runTime;
  // final List<String> genre;
  // final List<String> spokenLanguages;
  // final String tagLine;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.language,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    // required this.budgets,
    // required this.revenues,
    // required this.originCountry,
    // required this.status,
    // required this.runTime,
    // required this.genre,
    // required this.spokenLanguages,
    // required this.tagLine,
  });

  // Factory method to create a Movie instance from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Untitled',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? 'No overview available.',
      releaseDate: json['release_date'] ?? 'Unknown',
      language: json['original_language'] ?? 'Unknown',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      // tagLine: json['tagline'] ?? '',
      // budgets: [json['budget'] ?? 0],
      // revenues: [json['revenue'] ?? 0],
      // originCountry: json['production_countries'] != null &&
      //         json['production_countries'].isNotEmpty
      //     ? json['production_countries'][0]['iso_3166_1']
      //     : 'Unknown',
      // status: json['status'] ?? 'Unknown',
      // runTime: json['runtime'] ?? 0,
      // genre: json['genres'] != null
      //     ? json['genres'].map((g) => g['name']).toList()
      //     : [],
      // spokenLanguages:
      //     json['spoken_languages']?.map((lang) => lang['name']).toList() ?? [],
    );
  }

  static List<Movie> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Movie.fromJson(json)).toList();
  }
}
