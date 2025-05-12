// To parse this JSON data, do
//
//     final buygoldccavenuecall = buygoldccavenuecallFromJson(jsonString);

import 'dart:convert';

Buygoldccavenuecall buygoldccavenuecallFromJson(String str) =>
    Buygoldccavenuecall.fromJson(json.decode(str));

String buygoldccavenuecallToJson(Buygoldccavenuecall data) =>
    json.encode(data.toJson());

class Buygoldccavenuecall {
  String? orderId;
  String? id;
  String? totalPayableAmount;

  Buygoldccavenuecall({
    this.orderId,
    this.id,
    this.totalPayableAmount,
  });

  factory Buygoldccavenuecall.fromJson(Map<String, dynamic> json) =>
      Buygoldccavenuecall(
        orderId: json["order_id"],
        id: json["id"],
        totalPayableAmount: json["total_payable_amount"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "id": id,
        "total_payable_amount": totalPayableAmount,
      };
}
