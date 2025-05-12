// To parse this JSON data, do
//
//     final forgotpasswordresponse = forgotpasswordresponseFromJson(jsonString);

import 'dart:convert';

List<Forgotpasswordresponse> forgotpasswordresponseFromJson(String str) =>
    List<Forgotpasswordresponse>.from(
        json.decode(str).map((x) => Forgotpasswordresponse.fromJson(x)));

String forgotpasswordresponseToJson(List<Forgotpasswordresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forgotpasswordresponse {
  String? status;
  String? message;
  Data? data;

  Forgotpasswordresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Forgotpasswordresponse.fromJson(Map<String, dynamic> json) =>
      Forgotpasswordresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
