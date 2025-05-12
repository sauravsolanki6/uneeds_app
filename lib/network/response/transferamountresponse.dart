// To parse this JSON data, do
//
//     final transferamountresponse = transferamountresponseFromJson(jsonString);

import 'dart:convert';

List<Transferamountresponse> transferamountresponseFromJson(String str) =>
    List<Transferamountresponse>.from(
        json.decode(str).map((x) => Transferamountresponse.fromJson(x)));

String transferamountresponseToJson(List<Transferamountresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transferamountresponse {
  String? status;
  String? message;
  Data? data;

  Transferamountresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Transferamountresponse.fromJson(Map<String, dynamic> json) =>
      Transferamountresponse(
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
