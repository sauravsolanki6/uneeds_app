// To parse this JSON data, do
//
//     final enachurlcall = enachurlcallFromJson(jsonString);

import 'dart:convert';

List<Enachurlcall> enachurlcallFromJson(String str) => List<Enachurlcall>.from(
    json.decode(str).map((x) => Enachurlcall.fromJson(x)));

String enachurlcallToJson(List<Enachurlcall> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enachurlcall {
  String? orderId;
  String? emiOrderId;

  Enachurlcall({
    this.orderId,
    this.emiOrderId,
  });

  factory Enachurlcall.fromJson(Map<String, dynamic> json) => Enachurlcall(
        orderId: json["order_id"],
        emiOrderId: json["emi_order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "emi_order_id": emiOrderId,
      };
}
