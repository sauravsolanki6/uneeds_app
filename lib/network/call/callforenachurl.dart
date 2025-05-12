// To parse this JSON data, do
//
//     final callforenachurl = callforenachurlFromJson(jsonString);

import 'dart:convert';

Callforenachurl callforenachurlFromJson(String str) =>
    Callforenachurl.fromJson(json.decode(str));

String callforenachurlToJson(Callforenachurl data) =>
    json.encode(data.toJson());

class Callforenachurl {
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

  Callforenachurl({
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

  factory Callforenachurl.fromJson(Map<String, dynamic> json) =>
      Callforenachurl(
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
