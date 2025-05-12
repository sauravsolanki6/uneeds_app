// To parse this JSON data, do
//
//     final updateprofileresponse = updateprofileresponseFromJson(jsonString);

import 'dart:convert';

List<Updateprofileresponse> updateprofileresponseFromJson(String str) =>
    List<Updateprofileresponse>.from(
        json.decode(str).map((x) => Updateprofileresponse.fromJson(x)));

String updateprofileresponseToJson(List<Updateprofileresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Updateprofileresponse {
  String? status;
  String? message;

  Updateprofileresponse({
    this.status,
    this.message,
  });

  factory Updateprofileresponse.fromJson(Map<String, dynamic> json) =>
      Updateprofileresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
