class MovieListResponse {
  final int page;
  final List<Movie> results;
  final int totalResults;
  final int totalPages;

  MovieListResponse(
      this.page, this.results, this.totalResults, this.totalPages);

  MovieListResponse.fromJson(Map<String, dynamic> jsonMap)
      : page = jsonMap['page'],
        results = (jsonMap['results'] as List).map((map) {
          return Movie.fromJson(map);
        }).toList(),
        totalResults = jsonMap['total_results'],
        totalPages = jsonMap['total_pages'];

  Map<String, dynamic> toJson() =>
      {'results': results.map((genre) => genre.toJson()).toList()};
}

class Movie {
  int id;
  bool isAdult;
  String? posterPath;
  String overview;
  String releaseDate;
  List<int> genreIDs;
  String originalTitle;
  String originalLanguage;
  String title;
  String? backdropPath;
  num popularity;
  int voteCount;
  bool hasVideo;
  num voteAverage;

  Movie.fromJson(Map<String, dynamic> jsonMap)
      : isAdult = jsonMap['adult'],
        backdropPath = jsonMap['backdrop_path'],
        genreIDs = List<int>.from(jsonMap['genre_ids']),
        id = jsonMap['id'],
        originalLanguage = jsonMap['original_language'],
        originalTitle = jsonMap['original_title'],
        overview = jsonMap['overview'],
        popularity = jsonMap['popularity'],
        posterPath = jsonMap['poster_path'],
        releaseDate = jsonMap['release_date'],
        title = jsonMap['title'],
        hasVideo = jsonMap['video'],
        voteAverage = jsonMap['vote_average'],
        voteCount = jsonMap['vote_count'];

  Map<String, dynamic> toJson() => {
        'adult': isAdult,
        'backdrop_path': backdropPath,
        'genre_ids': genreIDs,
        'id': id,
        'original_language': originalLanguage,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'original_title': originalTitle,
        'video': hasVideo,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}
