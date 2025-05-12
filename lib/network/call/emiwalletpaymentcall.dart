// To parse this JSON data, do
//
//     final emiwalletpaymentcall = emiwalletpaymentcallFromJson(jsonString);

import 'dart:convert';

List<Emiwalletpaymentcall> emiwalletpaymentcallFromJson(String str) =>
    List<Emiwalletpaymentcall>.from(
        json.decode(str).map((x) => Emiwalletpaymentcall.fromJson(x)));

String emiwalletpaymentcallToJson(List<Emiwalletpaymentcall> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emiwalletpaymentcall {
  String? orderId;
  String? isDeduct;
  String? payableAmount;

  Emiwalletpaymentcall({
    this.orderId,
    this.isDeduct,
    this.payableAmount,
  });

  factory Emiwalletpaymentcall.fromJson(Map<String, dynamic> json) =>
      Emiwalletpaymentcall(
        orderId: json["order_id"],
        isDeduct: json["is_deduct"],
        payableAmount: json["payable_amount"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "is_deduct": isDeduct,
        "payable_amount": payableAmount,
      };
}
