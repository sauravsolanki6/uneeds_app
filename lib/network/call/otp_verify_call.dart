// To parse this JSON data, do
//
//     final otpverifycall = otpverifycallFromJson(jsonString);

import 'dart:convert';

Otpverifycall otpverifycallFromJson(String str) =>
    Otpverifycall.fromJson(json.decode(str));

String otpverifycallToJson(Otpverifycall data) => json.encode(data.toJson());

class Otpverifycall {
  int? otp;
  int? otp1;
  int? otp2;
  int? otp3;
  int? otp4;
  int? tblUnverifiedId;
  String? mobile;

  Otpverifycall({
    this.otp,
    this.otp1,
    this.otp2,
    this.otp3,
    this.otp4,
    this.tblUnverifiedId,
    this.mobile,
  });

  factory Otpverifycall.fromJson(Map<String, dynamic> json) => Otpverifycall(
        otp: json["otp"],
        otp1: json["otp1"],
        otp2: json["otp2"],
        otp3: json["otp3"],
        otp4: json["otp4"],
        tblUnverifiedId: json["tbl_unverified_id"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "otp1": otp1,
        "otp2": otp2,
        "otp3": otp3,
        "otp4": otp4,
        "tbl_unverified_id": tblUnverifiedId,
        "mobile": mobile,
      };
}
