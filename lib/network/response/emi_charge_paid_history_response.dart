// To parse this JSON data, do
//
//     final emichargepaidhistoryresponse = emichargepaidhistoryresponseFromJson(jsonString);

import 'dart:convert';

List<Emichargepaidhistoryresponse> emichargepaidhistoryresponseFromJson(
        String str) =>
    List<Emichargepaidhistoryresponse>.from(
        json.decode(str).map((x) => Emichargepaidhistoryresponse.fromJson(x)));

String emichargepaidhistoryresponseToJson(
        List<Emichargepaidhistoryresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emichargepaidhistoryresponse {
  String? status;
  String? message;
  List<EmichargepaidhistoryresponseDatum>? data;

  Emichargepaidhistoryresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Emichargepaidhistoryresponse.fromJson(Map<String, dynamic> json) =>
      Emichargepaidhistoryresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<EmichargepaidhistoryresponseDatum>.from(json["data"]!
                .map((x) => EmichargepaidhistoryresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EmichargepaidhistoryresponseDatum {
  String? id;
  String? customerId;
  String? installmentMonth;
  String? paidAmount;
  String? status;
  String? isDeleted;
  DateTime? createdOn;
  DateTime? updatedOn;

  EmichargepaidhistoryresponseDatum({
    this.id,
    this.customerId,
    this.installmentMonth,
    this.paidAmount,
    this.status,
    this.isDeleted,
    this.createdOn,
    this.updatedOn,
  });

  factory EmichargepaidhistoryresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      EmichargepaidhistoryresponseDatum(
        id: json["id"],
        customerId: json["customer_id"],
        installmentMonth: json["installment_month"],
        paidAmount: json["paid_amount"],
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
        "paid_amount": paidAmount,
        "status": status,
        "is_deleted": isDeleted,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
      };
}
