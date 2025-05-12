// To parse this JSON data, do
//
//     final placeorderemicall = placeorderemicallFromJson(jsonString);

import 'dart:convert';

Placeorderemicall placeorderemicallFromJson(String str) =>
    Placeorderemicall.fromJson(json.decode(str));

String placeorderemicallToJson(Placeorderemicall data) =>
    json.encode(data.toJson());

class Placeorderemicall {
  String? tblEmiOrderId;
  String? id;
  String? addressId;
  String? totalAmount;
  String? firstEmiPay;

  Placeorderemicall({
    this.tblEmiOrderId,
    this.id,
    this.addressId,
    this.totalAmount,
    this.firstEmiPay,
  });

  factory Placeorderemicall.fromJson(Map<String, dynamic> json) =>
      Placeorderemicall(
        tblEmiOrderId: json["tbl_emi_order_id"],
        id: json["id"],
        addressId: json["address_id"],
        totalAmount: json["total_amount"],
        firstEmiPay: json["first_emi_pay"],
      );

  Map<String, dynamic> toJson() => {
        "tbl_emi_order_id": tblEmiOrderId,
        "id": id,
        "address_id": addressId,
        "total_amount": totalAmount,
        "first_emi_pay": firstEmiPay,
      };
}
