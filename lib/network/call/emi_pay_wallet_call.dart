// To parse this JSON data, do
//
//     final emipaymentwalletcall = emipaymentwalletcallFromJson(jsonString);

import 'dart:convert';

Emipaymentwalletcall emipaymentwalletcallFromJson(String str) =>
    Emipaymentwalletcall.fromJson(json.decode(str));

String emipaymentwalletcallToJson(Emipaymentwalletcall data) =>
    json.encode(data.toJson());

class Emipaymentwalletcall {
  String? id;
  String? tblRepaymentId;
  String? allowedToPayEmiCharge;
  String? total_payable_amount;
  String? isdeductfromwallet;
  Emipaymentwalletcall({
    this.id,
    this.tblRepaymentId,
    this.allowedToPayEmiCharge,
    this.total_payable_amount,
    this.isdeductfromwallet,
  });

  factory Emipaymentwalletcall.fromJson(Map<String, dynamic> json) =>
      Emipaymentwalletcall(
        id: json["id"],
        tblRepaymentId: json["tbl_repayment_id"],
        allowedToPayEmiCharge: json["allowed_to_pay_emi_charge"],
        total_payable_amount: json["total_payable_amount"],
        isdeductfromwallet: json["isdeductfromwallet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_repayment_id": tblRepaymentId,
        "allowed_to_pay_emi_charge": allowedToPayEmiCharge,
        "total_payable_amount": total_payable_amount,
        "isdeductfromwallet": isdeductfromwallet,
      };
}
