// To parse this JSON data, do
//
//     final getenachtoakencall = getenachtoakencallFromJson(jsonString);

import 'dart:convert';

Getenachtoakencall getenachtoakencallFromJson(String str) =>
    Getenachtoakencall.fromJson(json.decode(str));

String getenachtoakencallToJson(Getenachtoakencall data) =>
    json.encode(data.toJson());

class Getenachtoakencall {
  String? customerId;
  String? orderId;

  Getenachtoakencall({
    this.customerId,
    this.orderId,
  });

  factory Getenachtoakencall.fromJson(Map<String, dynamic> json) =>
      Getenachtoakencall(
        customerId: json["customer_id"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "order_id": orderId,
      };
}
