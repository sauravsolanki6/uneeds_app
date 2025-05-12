// To parse this JSON data, do
//
//     final allamountresponse = allamountresponseFromJson(jsonString);

import 'dart:convert';

List<Allamountresponse> allamountresponseFromJson(String str) =>
    List<Allamountresponse>.from(
        json.decode(str).map((x) => Allamountresponse.fromJson(x)));

String allamountresponseToJson(List<Allamountresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allamountresponse {
  String? status;
  String? message;
  String? lateEmiPaidCharge;
  double? earnAmount;
  String? lateEmiCharge;
  String? deductAmount;
  double? walletBalance;

  Allamountresponse({
    this.status,
    this.message,
    this.lateEmiPaidCharge,
    this.earnAmount,
    this.lateEmiCharge,
    this.deductAmount,
    this.walletBalance,
  });

  factory Allamountresponse.fromJson(Map<String, dynamic> json) =>
      Allamountresponse(
        status: json["status"],
        message: json["message"],
        lateEmiPaidCharge: json["late_emi_paid_charge"],
        earnAmount: json["earn_amount"]?.toDouble(),
        lateEmiCharge: json["late_emi_charge"],
        deductAmount: json["deduct_amount"],
        walletBalance: json["wallet_balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "late_emi_paid_charge": lateEmiPaidCharge,
        "earn_amount": earnAmount,
        "late_emi_charge": lateEmiCharge,
        "deduct_amount": deductAmount,
        "wallet_balance": walletBalance,
      };
}
