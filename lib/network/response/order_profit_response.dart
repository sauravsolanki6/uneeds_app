// To parse this JSON data, do
//
//     final orderprofitresponse = orderprofitresponseFromJson(jsonString);

import 'dart:convert';

List<Orderprofitresponse> orderprofitresponseFromJson(String str) =>
    List<Orderprofitresponse>.from(
        json.decode(str).map((x) => Orderprofitresponse.fromJson(x)));

String orderprofitresponseToJson(List<Orderprofitresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orderprofitresponse {
  String? status;
  String? message;
  List<OrderprofitDatum>? data;

  Orderprofitresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Orderprofitresponse.fromJson(Map<String, dynamic> json) =>
      Orderprofitresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<OrderprofitDatum>.from(
                json["data"]!.map((x) => OrderprofitDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderprofitDatum {
  DateTime? paymentDate;
  String? purchaseLiveRate;
  String? purchaseGram;

  OrderprofitDatum({
    this.paymentDate,
    this.purchaseLiveRate,
    this.purchaseGram,
  });

  factory OrderprofitDatum.fromJson(Map<String, dynamic> json) =>
      OrderprofitDatum(
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        purchaseLiveRate: json["purchase_live_rate"],
        purchaseGram: json["purchase_gram"],
      );

  Map<String, dynamic> toJson() => {
        "payment_date":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "purchase_live_rate": purchaseLiveRate,
        "purchase_gram": purchaseGram,
      };
}
