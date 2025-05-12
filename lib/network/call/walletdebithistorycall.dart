// To parse this JSON data, do
//
//     final walletdebithstorycall = walletdebithstorycallFromJson(jsonString);

import 'dart:convert';

Walletdebithstorycall walletdebithstorycallFromJson(String str) =>
    Walletdebithstorycall.fromJson(json.decode(str));

String walletdebithstorycallToJson(Walletdebithstorycall data) =>
    json.encode(data.toJson());

class Walletdebithstorycall {
  String? customerId;

  Walletdebithstorycall({
    this.customerId,
  });

  factory Walletdebithstorycall.fromJson(Map<String, dynamic> json) =>
      Walletdebithstorycall(
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
      };
}
