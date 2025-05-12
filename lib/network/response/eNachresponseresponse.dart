// To parse this JSON data, do
//
//     final enachresponseresponse = enachresponseresponseFromJson(jsonString);

import 'dart:convert';

List<Enachresponseresponse> enachresponseresponseFromJson(String str) =>
    List<Enachresponseresponse>.from(
        json.decode(str).map((x) => Enachresponseresponse.fromJson(x)));

String enachresponseresponseToJson(List<Enachresponseresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enachresponseresponse {
  String? status;
  String? message;

  Enachresponseresponse({
    this.status,
    this.message,
  });

  factory Enachresponseresponse.fromJson(Map<String, dynamic> json) =>
      Enachresponseresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
