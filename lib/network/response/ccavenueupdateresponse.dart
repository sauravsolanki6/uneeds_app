// To parse this JSON data, do
//
//     final updatetheccavnueresponse = updatetheccavnueresponseFromJson(jsonString);

import 'dart:convert';

List<Updatetheccavnueresponse> updatetheccavnueresponseFromJson(String str) =>
    List<Updatetheccavnueresponse>.from(
        json.decode(str).map((x) => Updatetheccavnueresponse.fromJson(x)));

String updatetheccavnueresponseToJson(List<Updatetheccavnueresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Updatetheccavnueresponse {
  String? status;
  String? message;
  String? tei;

  Updatetheccavnueresponse({
    this.status,
    this.message,
    this.tei,
  });

  factory Updatetheccavnueresponse.fromJson(Map<String, dynamic> json) =>
      Updatetheccavnueresponse(
        status: json["status"],
        message: json["message"],
        tei: json["tei"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "tei": tei,
      };
}
