// To parse this JSON data, do
//
//     final bankaccountoperationresponse = bankaccountoperationresponseFromJson(jsonString);

import 'dart:convert';

List<Bankaccountoperationresponse> bankaccountoperationresponseFromJson(
        String str) =>
    List<Bankaccountoperationresponse>.from(
        json.decode(str).map((x) => Bankaccountoperationresponse.fromJson(x)));

String bankaccountoperationresponseToJson(
        List<Bankaccountoperationresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bankaccountoperationresponse {
  String? status;
  String? message;
  Data? data;

  Bankaccountoperationresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Bankaccountoperationresponse.fromJson(Map<String, dynamic> json) =>
      Bankaccountoperationresponse(
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
