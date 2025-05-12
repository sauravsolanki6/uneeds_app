// To parse this JSON data, do
//
//     final uniquefieldresponse = uniquefieldresponseFromJson(jsonString);

import 'dart:convert';

List<Uniquefieldresponse> uniquefieldresponseFromJson(String str) =>
    List<Uniquefieldresponse>.from(
        json.decode(str).map((x) => Uniquefieldresponse.fromJson(x)));

String uniquefieldresponseToJson(List<Uniquefieldresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Uniquefieldresponse {
  String? status;
  String? message;

  Uniquefieldresponse({
    this.status,
    this.message,
  });

  factory Uniquefieldresponse.fromJson(Map<String, dynamic> json) =>
      Uniquefieldresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
