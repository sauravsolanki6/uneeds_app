// To parse this JSON data, do
//
//     final sendrequestresponse = sendrequestresponseFromJson(jsonString);

import 'dart:convert';

List<Sendrequestresponse> sendrequestresponseFromJson(String str) =>
    List<Sendrequestresponse>.from(
        json.decode(str).map((x) => Sendrequestresponse.fromJson(x)));

String sendrequestresponseToJson(List<Sendrequestresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sendrequestresponse {
  String? status;
  String? message;

  Sendrequestresponse({
    this.status,
    this.message,
  });

  factory Sendrequestresponse.fromJson(Map<String, dynamic> json) =>
      Sendrequestresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
