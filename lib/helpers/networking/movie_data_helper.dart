import 'package:movie_libs/features/genre_list/models/genre_list_model.dart';
import 'package:movie_libs/features/movies_list/movies_list_model.dart';
import 'package:movie_libs/helpers/networking/error_model.dart';
import 'package:movie_libs/helpers/networking/network_constants.dart';
import 'package:movie_libs/helpers/networking/networking_helper.dart';

class MovieDataHelper {
  static Future<dynamic> getGenreList() async {
    final genres = await NetworkingHelper.get(path: kGetGenres);
    if (genres is Map<String, dynamic>) {
      return GenreListResponse.fromJson(genres).genres;
    }
    return genres;
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

  static String getImageURL({required String path}) {
    return '$kImageURL$path';
  }
}
