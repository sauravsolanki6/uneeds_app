// To parse this JSON data, do
//
//     final getenachurlcall = getenachurlcallFromJson(jsonString);

import 'dart:convert';

Getenachurlcall getenachurlcallFromJson(String str) =>
    Getenachurlcall.fromJson(json.decode(str));

String getenachurlcallToJson(Getenachurlcall data) =>
    json.encode(data.toJson());

class Getenachurlcall {
  String? orderId;

  Getenachurlcall({
    this.orderId,
  });

  factory Getenachurlcall.fromJson(Map<String, dynamic> json) =>
      Getenachurlcall(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
      };
}
