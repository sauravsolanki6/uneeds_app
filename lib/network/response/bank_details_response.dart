// To parse this JSON data, do
//
//     final bankdetailresponse = bankdetailresponseFromJson(jsonString);

import 'dart:convert';

List<Bankdetailresponse> bankdetailresponseFromJson(String str) =>
    List<Bankdetailresponse>.from(
        json.decode(str).map((x) => Bankdetailresponse.fromJson(x)));

String bankdetailresponseToJson(List<Bankdetailresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bankdetailresponse {
  String? status;
  String? message;
  List<BankdetailresponseDatum>? data;

  Bankdetailresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Bankdetailresponse.fromJson(Map<String, dynamic> json) =>
      Bankdetailresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BankdetailresponseDatum>.from(
                json["data"]!.map((x) => BankdetailresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BankdetailresponseDatum {
  String? id;
  String? customerId;
  String? account;
  String? bankName;
  String? branchName;
  String? accountNumber;
  String? accountType;
  String? ifscCode;
  String? micrNumber;
  dynamic upiId;
  dynamic scanerPhoto;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? status;
  String? isDeleted;
  String? imagePath;

  BankdetailresponseDatum({
    this.id,
    this.customerId,
    this.account,
    this.bankName,
    this.branchName,
    this.accountNumber,
    this.accountType,
    this.ifscCode,
    this.micrNumber,
    this.upiId,
    this.scanerPhoto,
    this.createdOn,
    this.updatedOn,
    this.status,
    this.isDeleted,
    this.imagePath,
  });

  factory BankdetailresponseDatum.fromJson(Map<String, dynamic> json) =>
      BankdetailresponseDatum(
        id: json["id"],
        customerId: json["customer_id"],
        account: json["account"],
        bankName: json["bank_name"],
        branchName: json["branch_name"],
        accountNumber: json["account_number"],
        accountType: json["account_type"],
        ifscCode: json["ifsc_code"],
        micrNumber: json["micr_number"],
        upiId: json["upi_id"],
        scanerPhoto: json["scaner_photo"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        status: json["status"],
        isDeleted: json["is_deleted"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "account": account,
        "bank_name": bankName,
        "branch_name": branchName,
        "account_number": accountNumber,
        "account_type": accountType,
        "ifsc_code": ifscCode,
        "micr_number": micrNumber,
        "upi_id": upiId,
        "scaner_photo": scanerPhoto,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "status": status,
        "is_deleted": isDeleted,
        "image_path": imagePath,
      };
}
