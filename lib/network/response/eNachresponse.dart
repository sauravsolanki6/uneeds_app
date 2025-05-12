// To parse this JSON data, do
//
//     final enachurlresponse = enachurlresponseFromJson(jsonString);

import 'dart:convert';

List<Enachurlresponse> enachurlresponseFromJson(String str) =>
    List<Enachurlresponse>.from(
        json.decode(str).map((x) => Enachurlresponse.fromJson(x)));

String enachurlresponseToJson(List<Enachurlresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enachurlresponse {
  String? status;
  String? message;
  List<EnachdataDatum>? data;

  Enachurlresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Enachurlresponse.fromJson(Map<String, dynamic> json) =>
      Enachurlresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<EnachdataDatum>.from(
                json["data"]!.map((x) => EnachdataDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EnachdataDatum {
  String? orderId;
  dynamic customerMobile;
  String? customerEmail;
  String? consumerId;
  String? txnId;
  String? emiStartDate;
  String? emiEndDate;
  String? emiAmount;
  String? emiMonth;
  String? token;
  String? enachFrom;

  EnachdataDatum({
    this.orderId,
    this.customerMobile,
    this.customerEmail,
    this.consumerId,
    this.txnId,
    this.emiStartDate,
    this.emiEndDate,
    this.emiAmount,
    this.emiMonth,
    this.token,
    this.enachFrom,
  });

  factory EnachdataDatum.fromJson(Map<String, dynamic> json) => EnachdataDatum(
        orderId: json["order_id"],
        customerMobile: json["customer_mobile"],
        customerEmail: json["customer_email"],
        consumerId: json["consumerId"],
        txnId: json["txnId"],
        emiStartDate: json["emi_start_date"],
        emiEndDate: json["emi_end_date"],
        emiAmount: json["emi_amount"],
        emiMonth: json["emi_month"],
        token: json["token"],
        enachFrom: json["enach_from"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_mobile": customerMobile,
        "customer_email": customerEmail,
        "consumerId": consumerId,
        "txnId": txnId,
        "emi_start_date": emiStartDate,
        "emi_end_date": emiEndDate,
        "emi_amount": emiAmount,
        "emi_month": emiMonth,
        "token": token,
        "enach_from": enachFrom,
      };
}
