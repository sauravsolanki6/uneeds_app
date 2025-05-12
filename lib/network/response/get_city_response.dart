// To parse this JSON data, do
//
//     final getcityresponse = getcityresponseFromJson(jsonString);

import 'dart:convert';

List<Getcityresponse> getcityresponseFromJson(String str) =>
    List<Getcityresponse>.from(
        json.decode(str).map((x) => Getcityresponse.fromJson(x)));

String getcityresponseToJson(List<Getcityresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getcityresponse {
  String? status;
  String? message;
  List<GetcityresponseDatum>? data;

  Getcityresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Getcityresponse.fromJson(Map<String, dynamic> json) =>
      Getcityresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetcityresponseDatum>.from(
                json["data"]!.map((x) => GetcityresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetcityresponseDatum {
  String? id;
  String? stateId;
  String? name;

  GetcityresponseDatum({
    this.id,
    this.stateId,
    this.name,
  });

  factory GetcityresponseDatum.fromJson(Map<String, dynamic> json) =>
      GetcityresponseDatum(
        id: json["id"],
        stateId: json["state_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "name": name,
      };
}
