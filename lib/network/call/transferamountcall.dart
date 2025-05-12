// To parse this JSON data, do
//
//     final transferamountcall = transferamountcallFromJson(jsonString);

import 'dart:convert';

Transferamountcall transferamountcallFromJson(String str) =>
    Transferamountcall.fromJson(json.decode(str));

String transferamountcallToJson(Transferamountcall data) =>
    json.encode(data.toJson());

class Transferamountcall {
  String? transferAmount;
  String? customerId;

  Transferamountcall({
    this.transferAmount,
    this.customerId,
  });

  factory Transferamountcall.fromJson(Map<String, dynamic> json) =>
      Transferamountcall(
        transferAmount: json["transfer_amount"],
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "transfer_amount": transferAmount,
        "customer_id": customerId,
      };
}
