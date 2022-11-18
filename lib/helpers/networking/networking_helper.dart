import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_libs/helpers/networking/error_model.dart';

// class NetworkClient {
//   static void getDataFromServer({
//     required String path,
//     Map<String, dynamic>? body,
//     required Function(int statusCode, Map<String, dynamic> response) callback,
//   }) async {
//     http.Response response = await NetworkService().get(path, body);
//     final statusCode = response.statusCode;
//     final Map<String, dynamic> decodedResponse = json.decode(response.body);
//     await callback(statusCode, decodedResponse);
//   }
// }

class NetworkService {
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? body,
  }) async {
    Map<String, dynamic> addedBody = {
      'api_key': 'a48deeb08653a50b070ed0dd82b8a87b'
    };
    if (body != null) {
      addedBody.addAll(body);
    }
    Uri url = Uri.https('api.themoviedb.org', path, addedBody);
    http.Response response = await http.get(url);
    Map<String, dynamic> decodedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      return decodedJson;
    } else {
      return TMDBError.fromJson(decodedJson);
    }
  }
}
