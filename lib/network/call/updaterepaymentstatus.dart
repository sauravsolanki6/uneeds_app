// To parse this JSON data, do
//
//     final updatetheemipaystatuscall = updatetheemipaystatuscallFromJson(jsonString);

import 'dart:convert';

Updatetheemirepaystatuscall updatetheemipaystatuscallFromJson(String str) =>
    Updatetheemirepaystatuscall.fromJson(json.decode(str));

String updatetheemirepaystatuscallToJson(Updatetheemirepaystatuscall data) =>
    json.encode(data.toJson());

class Updatetheemirepaystatuscall {
  String? transactionId;
  String? providerReferenceId;
  String? orderid;
  int? allowed_to_pay_charge_or_deduct;
  Updatetheemirepaystatuscall({
    this.transactionId,
    this.providerReferenceId,
    this.orderid,
    this.allowed_to_pay_charge_or_deduct,
  });

  factory Updatetheemirepaystatuscall.fromJson(Map<String, dynamic> json) =>
      Updatetheemirepaystatuscall(
        transactionId: json["transactionId"],
        providerReferenceId: json["providerReferenceId"],
        orderid: json["order_id"],
        allowed_to_pay_charge_or_deduct:
            json["allowed_to_pay_charge_or_deduct"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "providerReferenceId": providerReferenceId,
        "order_id": orderid,
        "allowed_to_pay_charge_or_deduct": allowed_to_pay_charge_or_deduct,
      };
}
