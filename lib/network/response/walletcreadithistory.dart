// To parse this JSON data, do
//
//     final walletcreadithstoryresponse = walletcreadithstoryresponseFromJson(jsonString);

import 'dart:convert';

List<Walletcreadithstoryresponse> walletcreadithstoryresponseFromJson(
        String str) =>
    List<Walletcreadithstoryresponse>.from(
        json.decode(str).map((x) => Walletcreadithstoryresponse.fromJson(x)));

String walletcreadithstoryresponseToJson(
        List<Walletcreadithstoryresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Walletcreadithstoryresponse {
  String? status;
  String? message;
  List<WalletcreadithstoryDatum>? data;

  Walletcreadithstoryresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Walletcreadithstoryresponse.fromJson(Map<String, dynamic> json) =>
      Walletcreadithstoryresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<WalletcreadithstoryDatum>.from(
                json["data"]!.map((x) => WalletcreadithstoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WalletcreadithstoryDatum {
  String? id;
  String? customerId;
  String? amount;
  String? amountBy;
  String? totalAmount;
  String? paymentMode;
  String? transactionNumber;
  String? historyType;
  DateTime? payemntDate;
  String? remark;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;

  WalletcreadithstoryDatum({
    this.id,
    this.customerId,
    this.amount,
    this.amountBy,
    this.totalAmount,
    this.paymentMode,
    this.transactionNumber,
    this.historyType,
    this.payemntDate,
    this.remark,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
  });

  factory WalletcreadithstoryDatum.fromJson(Map<String, dynamic> json) =>
      WalletcreadithstoryDatum(
        id: json["id"],
        customerId: json["customer_id"],
        amount: json["amount"],
        amountBy: json["amount_by"],
        totalAmount: json["total_amount"],
        paymentMode: json["payment_mode"]!,
        transactionNumber: json["transaction_number"],
        historyType: json["history_type"],
        payemntDate: json["payemnt_date"] == null
            ? null
            : DateTime.parse(json["payemnt_date"]),
        remark: json["remark"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "amount": amount,
        "amount_by": amountBy,
        "total_amount": totalAmount,
        "payment_mode": paymentMode,
        "transaction_number": transactionNumber,
        "history_type": historyType,
        "payemnt_date":
            "${payemntDate!.year.toString().padLeft(4, '0')}-${payemntDate!.month.toString().padLeft(2, '0')}-${payemntDate!.day.toString().padLeft(2, '0')}",
        "remark": remark,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
      };
}
