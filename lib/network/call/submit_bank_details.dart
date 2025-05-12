// To parse this JSON data, do
//
//     final submitbankdetailscall = submitbankdetailscallFromJson(jsonString);

import 'dart:convert';

Submitbankdetailscall submitbankdetailscallFromJson(String str) =>
    Submitbankdetailscall.fromJson(json.decode(str));

String submitbankdetailscallToJson(Submitbankdetailscall data) =>
    json.encode(data.toJson());

class Submitbankdetailscall {
  String? id;
  String? bankName;
  String? branchName;
  String? accountNumber;
  String? accountType;
  String? ifscCode;
  String? micrNumber;
  String? oldImage;
  String? image;
  String? upiId;

  Submitbankdetailscall({
    this.id,
    this.bankName,
    this.branchName,
    this.accountNumber,
    this.accountType,
    this.ifscCode,
    this.micrNumber,
    this.oldImage,
    this.image,
    this.upiId,
  });

  factory Submitbankdetailscall.fromJson(Map<String, dynamic> json) =>
      Submitbankdetailscall(
          id: json["id"],
          bankName: json["bank_name"],
          branchName: json["branch_name"],
          accountNumber: json["account_number"],
          accountType: json["account_type"],
          ifscCode: json["ifsc_code"],
          micrNumber: json["micr_number"],
          oldImage: json["old_image"],
          image: json["scaner_photo"],
          upiId: json["upi_id"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "branch_name": branchName,
        "account_number": accountNumber,
        "account_type": accountType,
        "ifsc_code": ifscCode,
        "micr_number": micrNumber,
        "old_image": oldImage,
        "scaner_photo": image,
        "upi_id": upiId,
      };
}
