// To parse this JSON data, do
//
//     final getstateresponse = getstateresponseFromJson(jsonString);

import 'dart:convert';

List<Getstateresponse> getstateresponseFromJson(String str) =>
    List<Getstateresponse>.from(
        json.decode(str).map((x) => Getstateresponse.fromJson(x)));

String getstateresponseToJson(List<Getstateresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getstateresponse {
  String? status;
  String? message;
  List<GetstateresponseDatum>? data;

  Getstateresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Getstateresponse.fromJson(Map<String, dynamic> json) =>
      Getstateresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetstateresponseDatum>.from(
                json["data"]!.map((x) => GetstateresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetstateresponseDatum {
  String? id;
  String? countryId;
  String? name;

  GetstateresponseDatum({
    this.id,
    this.countryId,
    this.name,
  });

  factory GetstateresponseDatum.fromJson(Map<String, dynamic> json) =>
      GetstateresponseDatum(
        id: json["id"],
        countryId: json["country_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "name": name,
      };
}
