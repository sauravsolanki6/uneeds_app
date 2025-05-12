// To parse this JSON data, do
//
//     final emipaymentwalletresponse = emipaymentwalletresponseFromJson(jsonString);

import 'dart:convert';

List<Emipaymentwalletresponse> emipaymentwalletresponseFromJson(String str) =>
    List<Emipaymentwalletresponse>.from(
        json.decode(str).map((x) => Emipaymentwalletresponse.fromJson(x)));

String emipaymentwalletresponseToJson(List<Emipaymentwalletresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emipaymentwalletresponse {
  String? status;
  String? message;

  Emipaymentwalletresponse({
    this.status,
    this.message,
  });

  factory Emipaymentwalletresponse.fromJson(Map<String, dynamic> json) =>
      Emipaymentwalletresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
