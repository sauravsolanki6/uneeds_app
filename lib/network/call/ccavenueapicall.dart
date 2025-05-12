// To parse this JSON data, do
//
//     final ccavenueapicall = ccavenueapicallFromJson(jsonString);

import 'dart:convert';

Ccavenueapicall ccavenueapicallFromJson(String str) =>
    Ccavenueapicall.fromJson(json.decode(str));

String ccavenueapicallToJson(Ccavenueapicall data) =>
    json.encode(data.toJson());

class Ccavenueapicall {
  int? orderId;

  Ccavenueapicall({
    this.orderId,
  });

  factory Ccavenueapicall.fromJson(Map<String, dynamic> json) =>
      Ccavenueapicall(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
      };
}
