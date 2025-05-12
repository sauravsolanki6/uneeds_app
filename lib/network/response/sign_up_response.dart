// To parse this JSON data, do
//
//     final signupresponse = signupresponseFromJson(jsonString);

import 'dart:convert';

List<Signupresponse> signupresponseFromJson(String str) =>
    List<Signupresponse>.from(
        json.decode(str).map((x) => Signupresponse.fromJson(x)));

String signupresponseToJson(List<Signupresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Signupresponse {
  String? status;
  String? message;
  SignupData? data;

  Signupresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Signupresponse.fromJson(Map<String, dynamic> json) => Signupresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : SignupData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class SignupData {
  String? mobile;
  int? otp;
  int? tblUnverifiedId;

  SignupData({
    this.mobile,
    this.otp,
    this.tblUnverifiedId,
  });

  factory SignupData.fromJson(Map<String, dynamic> json) => SignupData(
        mobile: json["mobile"],
        otp: json["otp"],
        tblUnverifiedId: json["tbl_unverified_id"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "otp": otp,
        "tbl_unverified_id": tblUnverifiedId,
      };
}
