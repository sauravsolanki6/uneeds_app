// To parse this JSON data, do
//
//     final emichargehistoryresponse = emichargehistoryresponseFromJson(jsonString);

import 'dart:convert';

List<Emichargehistoryresponse> emichargehistoryresponseFromJson(String str) =>
    List<Emichargehistoryresponse>.from(
        json.decode(str).map((x) => Emichargehistoryresponse.fromJson(x)));

String emichargehistoryresponseToJson(List<Emichargehistoryresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emichargehistoryresponse {
  String? status;
  String? message;
  List<EmichargehistoryresponseDatum>? data;

  Emichargehistoryresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Emichargehistoryresponse.fromJson(Map<String, dynamic> json) =>
      Emichargehistoryresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<EmichargehistoryresponseDatum>.from(json["data"]!
                .map((x) => EmichargehistoryresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EmichargehistoryresponseDatum {
  String? id;
  String? customerId;
  String? installmentMonth;
  String? purchaseGram;
  String? tblRepaymentId;
  DateTime? paymentDate;
  DateTime? paymentDoneOn;
  String? chargeAmount;
  String? status;
  String? isDeleted;
  DateTime? createdOn;
  DateTime? updatedOn;

  EmichargehistoryresponseDatum({
    this.id,
    this.customerId,
    this.installmentMonth,
    this.purchaseGram,
    this.tblRepaymentId,
    this.paymentDate,
    this.paymentDoneOn,
    this.chargeAmount,
    this.status,
    this.isDeleted,
    this.createdOn,
    this.updatedOn,
  });

  factory EmichargehistoryresponseDatum.fromJson(Map<String, dynamic> json) =>
      EmichargehistoryresponseDatum(
        id: json["id"],
        customerId: json["customer_id"],
        installmentMonth: json["installment_month"],
        purchaseGram: json["purchase_gram"],
        tblRepaymentId: json["tbl_repayment_id"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        paymentDoneOn: json["payment_done_on"] == null
            ? null
            : DateTime.parse(json["payment_done_on"]),
        chargeAmount: json["charge_amount"],
        status: json["status"],
        isDeleted: json["is_deleted"],
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
        "installment_month": installmentMonth,
        "purchase_gram": purchaseGram,
        "tbl_repayment_id": tblRepaymentId,
        "payment_date": paymentDate?.toIso8601String(),
        "payment_done_on": paymentDoneOn?.toIso8601String(),
        "charge_amount": chargeAmount,
        "status": status,
        "is_deleted": isDeleted,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
      };
}
