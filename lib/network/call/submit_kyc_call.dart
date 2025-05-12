// To parse this JSON data, do
//
//     final submitkyccall = submitkyccallFromJson(jsonString);

import 'dart:convert';

Submitkyccall submitkyccallFromJson(String str) =>
    Submitkyccall.fromJson(json.decode(str));

String submitkyccallToJson(Submitkyccall data) => json.encode(data.toJson());

class Submitkyccall {
  String? kycAddharFront;
  String? kycAddharBack;
  String? kycPan;
  String? kycPassport;
  String? id;
  String? acceptAgreement;

  Submitkyccall({
    this.kycAddharFront,
    this.kycAddharBack,
    this.kycPan,
    this.kycPassport,
    this.id,
    this.acceptAgreement,
  });

  factory Submitkyccall.fromJson(Map<String, dynamic> json) => Submitkyccall(
        kycAddharFront: json["kyc_addhar_front"],
        kycAddharBack: json["kyc_addhar_back"],
        kycPan: json["kyc_pan"],
        kycPassport: json["kyc_passport"],
        id: json["id"],
        acceptAgreement: json["accept_agreement"],
      );

  Map<String, dynamic> toJson() => {
        "kyc_addhar_front": kycAddharFront,
        "kyc_addhar_back": kycAddharBack,
        "kyc_pan": kycPan,
        "kyc_passport": kycPassport,
        "id": id,
        "accept_agreement": acceptAgreement,
      };
}
