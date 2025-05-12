// To parse this JSON data, do
//
//     final deleteaccountresponse = deleteaccountresponseFromJson(jsonString);

import 'dart:convert';

List<Deleteaccountresponse> deleteaccountresponseFromJson(String str) =>
    List<Deleteaccountresponse>.from(
        json.decode(str).map((x) => Deleteaccountresponse.fromJson(x)));

String deleteaccountresponseToJson(List<Deleteaccountresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Deleteaccountresponse {
  String? status;
  String? message;
  Data? data;

  Deleteaccountresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Deleteaccountresponse.fromJson(Map<String, dynamic> json) =>
      Deleteaccountresponse(
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
