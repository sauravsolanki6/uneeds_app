// To parse this JSON data, do
//
//     final emiinvoicecall = emiinvoicecallFromJson(jsonString);

import 'dart:convert';

Emiinvoicecall emiinvoicecallFromJson(String str) =>
    Emiinvoicecall.fromJson(json.decode(str));

String emiinvoicecallToJson(Emiinvoicecall data) => json.encode(data.toJson());

class Emiinvoicecall {
  String? id;
  String? orderId;

  Emiinvoicecall({
    this.id,
    this.orderId,
  });

  factory Emiinvoicecall.fromJson(Map<String, dynamic> json) => Emiinvoicecall(
        id: json["id"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
      };
}
