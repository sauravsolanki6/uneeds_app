// To parse this JSON data, do
//
//     final updatecustomeridresponse = updatecustomeridresponseFromJson(jsonString);

import 'dart:convert';

List<Updatecustomeridresponse> updatecustomeridresponseFromJson(String str) =>
    List<Updatecustomeridresponse>.from(
        json.decode(str).map((x) => Updatecustomeridresponse.fromJson(x)));

String updatecustomeridresponseToJson(List<Updatecustomeridresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Updatecustomeridresponse {
  String? status;
  String? message;

  Updatecustomeridresponse({
    this.status,
    this.message,
  });

  factory Updatecustomeridresponse.fromJson(Map<String, dynamic> json) =>
      Updatecustomeridresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
