// To parse this JSON data, do
//
//     final genresResponseModel = genresResponseModelFromJson(jsonString);

import 'dart:convert';

GenresResponseModel genresResponseModelFromJson(String str) =>
    GenresResponseModel.fromJson(json.decode(str));

String genresResponseModelToJson(GenresResponseModel data) =>
    json.encode(data.toJson());

class GenresResponseModel {
  GenresResponseModel({
    this.genres,
  });

  List<Genre>? genres;

  factory GenresResponseModel.fromJson(Map<String, dynamic> json) =>
      GenresResponseModel(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
