// To parse this JSON data, do
//
//     final submitbankdetailsresponse = submitbankdetailsresponseFromJson(jsonString);

import 'dart:convert';

List<Submitbankdetailsresponse> submitbankdetailsresponseFromJson(String str) =>
    List<Submitbankdetailsresponse>.from(
        json.decode(str).map((x) => Submitbankdetailsresponse.fromJson(x)));

String submitbankdetailsresponseToJson(List<Submitbankdetailsresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Submitbankdetailsresponse {
  String? status;
  String? message;
  List<Datum>? data;

  Submitbankdetailsresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Submitbankdetailsresponse.fromJson(Map<String, dynamic> json) =>
      Submitbankdetailsresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
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

  Datum({
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
      };
}
