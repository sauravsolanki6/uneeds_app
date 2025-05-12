// To parse this JSON data, do
//
//     final buygoldwalletstatusresponse = buygoldwalletstatusresponseFromJson(jsonString);

import 'dart:convert';

List<Buygoldwalletstatusresponse> buygoldwalletstatusresponseFromJson(
        String str) =>
    List<Buygoldwalletstatusresponse>.from(
        json.decode(str).map((x) => Buygoldwalletstatusresponse.fromJson(x)));

String buygoldwalletstatusresponseToJson(
        List<Buygoldwalletstatusresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buygoldwalletstatusresponse {
  String? status;
  String? message;
  Data? data;

  Buygoldwalletstatusresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Buygoldwalletstatusresponse.fromJson(Map<String, dynamic> json) =>
      Buygoldwalletstatusresponse(
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
