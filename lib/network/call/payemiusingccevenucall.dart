// To parse this JSON data, do
//
//     final payemiusingccavenuecall = payemiusingccavenuecallFromJson(jsonString);

import 'dart:convert';

List<Payemiusingccavenuecall> payemiusingccavenuecallFromJson(String str) =>
    List<Payemiusingccavenuecall>.from(
        json.decode(str).map((x) => Payemiusingccavenuecall.fromJson(x)));

String payemiusingccavenuecallToJson(List<Payemiusingccavenuecall> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payemiusingccavenuecall {
  String? orderId;
  String? id;
  String? totalPayableAmount;
  int? allowed_to_pay_charge_or_deduct;
  Payemiusingccavenuecall({
    this.orderId,
    this.id,
    this.totalPayableAmount,
    this.allowed_to_pay_charge_or_deduct,
  });

  factory Payemiusingccavenuecall.fromJson(Map<String, dynamic> json) =>
      Payemiusingccavenuecall(
          orderId: json["order_id"],
          id: json["id"],
          totalPayableAmount: json["total_payable_amount"],
          allowed_to_pay_charge_or_deduct:
              json["allowed_to_pay_charge_or_deduct"]);

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "id": id,
        "total_payable_amount": totalPayableAmount,
        "allowed_to_pay_charge_or_deduct": allowed_to_pay_charge_or_deduct
      };
}
