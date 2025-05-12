// To parse this JSON data, do
//
//     final tdshistoryresponse = tdshistoryresponseFromJson(jsonString);

import 'dart:convert';

List<Tdshistoryresponse> tdshistoryresponseFromJson(String str) =>
    List<Tdshistoryresponse>.from(
        json.decode(str).map((x) => Tdshistoryresponse.fromJson(x)));

String tdshistoryresponseToJson(List<Tdshistoryresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tdshistoryresponse {
  String? status;
  String? message;
  List<TdshistoryDatum>? data;

  Tdshistoryresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Tdshistoryresponse.fromJson(Map<String, dynamic> json) =>
      Tdshistoryresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TdshistoryDatum>.from(
                json["data"]!.map((x) => TdshistoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TdshistoryDatum {
  String? id;
  String? customerId;
  String? withdrawAmount;
  String? tdsDeductAmount;
  String? requestStatus;
  dynamic rejectedReason;
  DateTime? statusChangeDate;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? isDeleted;
  String? status;

  TdshistoryDatum({
    this.id,
    this.customerId,
    this.withdrawAmount,
    this.tdsDeductAmount,
    this.requestStatus,
    this.rejectedReason,
    this.statusChangeDate,
    this.createdOn,
    this.updatedOn,
    this.isDeleted,
    this.status,
  });

  factory TdshistoryDatum.fromJson(Map<String, dynamic> json) =>
      TdshistoryDatum(
        id: json["id"],
        customerId: json["customer_id"],
        withdrawAmount: json["withdraw_amount"],
        tdsDeductAmount: json["tds_deduct_amount"],
        requestStatus: json["request_status"],
        rejectedReason: json["rejected_reason"],
        statusChangeDate: json["status_change_date"] == null
            ? null
            : DateTime.parse(json["status_change_date"]),
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        isDeleted: json["is_deleted"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "withdraw_amount": withdrawAmount,
        "tds_deduct_amount": tdsDeductAmount,
        "request_status": requestStatus,
        "rejected_reason": rejectedReason,
        "status_change_date": statusChangeDate?.toIso8601String(),
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "is_deleted": isDeleted,
        "status": status,
      };
}
