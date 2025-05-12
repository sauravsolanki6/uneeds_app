// To parse this JSON data, do
//
//     final updatetheemipaystatuscall = updatetheemipaystatuscallFromJson(jsonString);

import 'dart:convert';

Updatetheemipaystatuscall updatetheemipaystatuscallFromJson(String str) =>
    Updatetheemipaystatuscall.fromJson(json.decode(str));

String updatetheemipaystatuscallToJson(Updatetheemipaystatuscall data) =>
    json.encode(data.toJson());

class Updatetheemipaystatuscall {
  String? transactionId;
  String? providerReferenceId;
  String? orderid;
  Updatetheemipaystatuscall({
    this.transactionId,
    this.providerReferenceId,
    this.orderid,
  });

  factory Updatetheemipaystatuscall.fromJson(Map<String, dynamic> json) =>
      Updatetheemipaystatuscall(
        transactionId: json["transactionId"],
        providerReferenceId: json["providerReferenceId"],
        orderid: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "providerReferenceId": providerReferenceId,
        "order_id": orderid
      };
}
