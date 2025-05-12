// To parse this JSON data, do
//
//     final uniquereferalcall = uniquereferalcallFromJson(jsonString);

import 'dart:convert';

Uniquereferalcall uniquereferalcallFromJson(String str) =>
    Uniquereferalcall.fromJson(json.decode(str));

String uniquereferalcallToJson(Uniquereferalcall data) =>
    json.encode(data.toJson());

class Uniquereferalcall {
  String? referralCode;

  Uniquereferalcall({
    this.referralCode,
  });

  factory Uniquereferalcall.fromJson(Map<String, dynamic> json) =>
      Uniquereferalcall(
        referralCode: json["referral_code"],
      );

  Map<String, dynamic> toJson() => {
        "referral_code": referralCode,
      };
}
