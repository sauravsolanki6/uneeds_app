// To parse this JSON data, do
//
//     final viewemiordercall = viewemiordercallFromJson(jsonString);

import 'dart:convert';

Viewemiordercall viewemiordercallFromJson(String str) =>
    Viewemiordercall.fromJson(json.decode(str));

String viewemiordercallToJson(Viewemiordercall data) =>
    json.encode(data.toJson());

class Viewemiordercall {
  String? orderId;

  Viewemiordercall({
    this.orderId,
  });

  factory Viewemiordercall.fromJson(Map<String, dynamic> json) =>
      Viewemiordercall(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
      };
}
