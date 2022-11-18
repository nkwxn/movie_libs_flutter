class GenreListResponse {
  List<Genre> genres;

  GenreListResponse(this.genres);

  GenreListResponse.fromJson(Map<String, dynamic> jsonMap)
      : genres = (jsonMap['genres'] as List).map((map) {
          return Genre.fromJson(map);
        }).toList();

  Map<String, dynamic> toJson() =>
      {'genres': genres.map((genre) => genre.toJson()).toList()};
}

class Genre {
  String id;
  String name;

  Genre(this.id, this.name);

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'].toString();

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
