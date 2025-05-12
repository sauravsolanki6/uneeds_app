// To parse this JSON data, do
//
//     final withdrawhistoryresponse = withdrawhistoryresponseFromJson(jsonString);

import 'dart:convert';

List<Withdrawhistoryresponse> withdrawhistoryresponseFromJson(String str) =>
    List<Withdrawhistoryresponse>.from(
        json.decode(str).map((x) => Withdrawhistoryresponse.fromJson(x)));

String withdrawhistoryresponseToJson(List<Withdrawhistoryresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Withdrawhistoryresponse {
  String? status;
  String? message;
  String? totalTdsDeduct;

  List<WithdrawhistoryresponseDatum>? data;

  Withdrawhistoryresponse({
    this.status,
    this.message,
    this.totalTdsDeduct,
    this.data,
  });

  factory Withdrawhistoryresponse.fromJson(Map<String, dynamic> json) =>
      Withdrawhistoryresponse(
        status: json["status"],
        message: json["message"],
        totalTdsDeduct: json["total_tds_deduct"],
        data: json["data"] == null
            ? []
            : List<WithdrawhistoryresponseDatum>.from(json["data"]!
                .map((x) => WithdrawhistoryresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total_tds_deduct": totalTdsDeduct,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WithdrawhistoryresponseDatum {
  String? id;
  String? customerId;
  String? emiMonth;
  String? deductAmount;
  String? tblRepaymentId;
  String? deductVia;
  String? isDeleted;
  String? status;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? deduct_via;

  WithdrawhistoryresponseDatum({
    this.id,
    this.customerId,
    this.emiMonth,
    this.deductAmount,
    this.tblRepaymentId,
    this.deductVia,
    this.isDeleted,
    this.status,
    this.createdOn,
    this.updatedOn,
    this.deduct_via,
  });

  factory WithdrawhistoryresponseDatum.fromJson(Map<String, dynamic> json) =>
      WithdrawhistoryresponseDatum(
        id: json["id"],
        customerId: json["customer_id"],
        emiMonth: json["emi_month"],
        deductAmount: json["deduct_amount"],
        tblRepaymentId: json["tbl_repayment_id"],
        deduct_via: json["deduct_via"],
        isDeleted: json["is_deleted"],
        status: json["status"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        deductVia: json["deductVia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "emi_month": emiMonth,
        "deduct_amount": deductAmount,
        "tbl_repayment_id": tblRepaymentId,
        "deduct_via": deduct_via,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "deductVia": deductVia,
      };
}
