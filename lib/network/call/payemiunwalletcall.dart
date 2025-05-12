// To parse this JSON data, do
//
//     final payemiunwalletcall = payemiunwalletcallFromJson(jsonString);

import 'dart:convert';

Payemiunwalletcall payemiunwalletcallFromJson(String str) =>
    Payemiunwalletcall.fromJson(json.decode(str));

String payemiunwalletcallToJson(Payemiunwalletcall data) =>
    json.encode(data.toJson());

class Payemiunwalletcall {
  String? orderId;
  int? isEmiAndLatefeeDeduct;

  Payemiunwalletcall({
    this.orderId,
    this.isEmiAndLatefeeDeduct,
  });

  factory Payemiunwalletcall.fromJson(Map<String, dynamic> json) =>
      Payemiunwalletcall(
        orderId: json["order_id"],
        isEmiAndLatefeeDeduct: json["is_emi_and_latefee_deduct"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "is_emi_and_latefee_deduct": isEmiAndLatefeeDeduct,
      };
}
