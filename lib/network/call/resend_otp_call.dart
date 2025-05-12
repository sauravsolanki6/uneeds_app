// To parse this JSON data, do
//
//     final resendotpcall = resendotpcallFromJson(jsonString);

import 'dart:convert';

Resendotpcall resendotpcallFromJson(String str) =>
    Resendotpcall.fromJson(json.decode(str));

String resendotpcallToJson(Resendotpcall data) => json.encode(data.toJson());

class Resendotpcall {
  String? mobile;
  String? otp;
  int? tbl_unverified_id;
  Resendotpcall({
    this.mobile,
    this.otp,
    this.tbl_unverified_id,
  });

  factory Resendotpcall.fromJson(Map<String, dynamic> json) => Resendotpcall(
        mobile: json["mobile"],
        otp: json["otp"],
        tbl_unverified_id: json["tbl_unverified_id"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "otp": otp,
        "tbl_unverified_id": tbl_unverified_id,
      };
}
