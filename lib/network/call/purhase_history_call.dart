// To parse this JSON data, do
//
//     final purchasehistorycall = purchasehistorycallFromJson(jsonString);

import 'dart:convert';

Purchasehistorycall purchasehistorycallFromJson(String str) =>
    Purchasehistorycall.fromJson(json.decode(str));

String purchasehistorycallToJson(Purchasehistorycall data) =>
    json.encode(data.toJson());

class Purchasehistorycall {
  String? customerId;

  Purchasehistorycall({
    this.customerId,
  });

  factory Purchasehistorycall.fromJson(Map<String, dynamic> json) =>
      Purchasehistorycall(
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
      };
}
