// To parse this JSON data, do
//
//     final trackemiordercall = trackemiordercallFromJson(jsonString);

import 'dart:convert';

Trackemiordercall trackemiordercallFromJson(String str) =>
    Trackemiordercall.fromJson(json.decode(str));

String trackemiordercallToJson(Trackemiordercall data) =>
    json.encode(data.toJson());

class Trackemiordercall {
  String? orderId;
  String? orderStatus;

  Trackemiordercall({
    this.orderId,
    this.orderStatus,
  });

  factory Trackemiordercall.fromJson(Map<String, dynamic> json) =>
      Trackemiordercall(
        orderId: json["order_id"],
        orderStatus: json["order_status"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_status": orderStatus,
      };
}
