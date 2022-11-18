import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_libs/helpers/networking/error_model.dart';
import 'package:movie_libs/helpers/networking/network_constants.dart';

class NetworkingHelper {
  static Future<dynamic> get({
    required String path,
    Map<String, dynamic>? body,
  }) async {
    Map<String, dynamic> addedBody = {
      'api_key': 'a48deeb08653a50b070ed0dd82b8a87b'
    };
    if (body != null) {
      addedBody.addAll(body);
      print(addedBody);
    }
    Uri url = Uri.https(kApiURL, path, addedBody);
    http.Response response = await http.get(url);
    print(response.body);
    Map<String, dynamic> decodedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      return decodedJson;
    } else {
      return TMDBError.fromJson(decodedJson);
    }
  }
}
