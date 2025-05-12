// To parse this JSON data, do
//
//     final buygoldwalletcall = buygoldwalletcallFromJson(jsonString);

import 'dart:convert';

List<Buygoldwalletcall> buygoldwalletcallFromJson(String str) =>
    List<Buygoldwalletcall>.from(
        json.decode(str).map((x) => Buygoldwalletcall.fromJson(x)));

String buygoldwalletcallToJson(List<Buygoldwalletcall> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buygoldwalletcall {
  String? orderId;

  Buygoldwalletcall({
    this.orderId,
  });

  factory Buygoldwalletcall.fromJson(Map<String, dynamic> json) =>
      Buygoldwalletcall(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
      };
}
