import 'package:movie_libs/helpers/models/genre_list_model.dart';
import 'package:movie_libs/helpers/models/movies_list_model.dart';
import 'package:movie_libs/helpers/networking/error_model.dart';
import 'package:movie_libs/helpers/networking/network_constants.dart';
import 'package:movie_libs/helpers/networking/networking_helper.dart';

class MovieDataHelper {
  static Map<int, String> _genresMapData = {};

  static Future<dynamic> getGenreList() async {
    final genres = await NetworkingHelper.get(path: kGetGenres);
    if (genres is Map<String, dynamic>) {
      final genresResponse = GenreListResponse.fromJson(genres);
      _genresMapData = {
        for (Genre genre in genresResponse.genres) genre.id: genre.name,
      };
      return genresResponse.genres;
    }
    return genres;
  }

  static List<String> getGenreNames({required List<int> withGenreIDs}) {
    return [for (int id in withGenreIDs) _genresMapData[id] ?? ''];
  }

  static Future<dynamic>? getMovieList({
    required int genreId,
    int page = 1,
  }) async {
    final movies = await NetworkingHelper.get(path: kGetMovieList, body: {
      'with_genres': genreId.toString(),
      'page': page.toString(),
    });
    if (movies is Map<String, dynamic>) {
      return MovieListResponse.fromJson(movies);
    }
    return movies;
  }

  static Future<dynamic>? getMovieDetails({
    required int movieId,
  }) async {
    final movieDetails = await NetworkingHelper.get(path: kGetMovieDetails(movieId: '$movieId'));
    
  }

  static String getImageURL({required String path}) {
    return '$kImageURL$path';
  }
}
