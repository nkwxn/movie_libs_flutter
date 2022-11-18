import 'package:movie_libs/features/genre_list/models/genre_list_model.dart';
import 'package:movie_libs/helpers/networking/error_model.dart';
import 'package:movie_libs/helpers/networking/network_constants.dart';
import 'package:movie_libs/helpers/networking/networking_helper.dart';

class MovieDataHelper {
  static Future<dynamic> getGenreList() async {
    final genres = await NetworkService().get(path: kGetGenres);
    if (genres is Map<String, dynamic>) {
      return GenreListResponse.fromJson(genres).genres;
    }
    return genres;
  }
}
