// To parse this JSON data, do
//
//     final purchasehistoryresponse = purchasehistoryresponseFromJson(jsonString);

import 'dart:convert';

List<Purchasehistoryresponse> purchasehistoryresponseFromJson(String str) =>
    List<Purchasehistoryresponse>.from(
        json.decode(str).map((x) => Purchasehistoryresponse.fromJson(x)));

String purchasehistoryresponseToJson(List<Purchasehistoryresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Purchasehistoryresponse {
  String? status;
  String? message;
  List<PurchasehistoryDatum>? data;

  Purchasehistoryresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Purchasehistoryresponse.fromJson(Map<String, dynamic> json) =>
      Purchasehistoryresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<PurchasehistoryDatum>.from(
                json["data"]!.map((x) => PurchasehistoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PurchasehistoryDatum {
  DateTime? paymentDate;
  String? purchaseGram;

  PurchasehistoryDatum({
    this.paymentDate,
    this.purchaseGram,
  });

  factory PurchasehistoryDatum.fromJson(Map<String, dynamic> json) =>
      PurchasehistoryDatum(
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        purchaseGram: json["purchase_gram"],
      );

  Map<String, dynamic> toJson() => {
        "payment_date":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "purchase_gram": purchaseGram,
      };
}
