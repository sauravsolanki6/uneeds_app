// To parse this JSON data, do
//
//     final getenachtoakenresponse = getenachtoakenresponseFromJson(jsonString);

import 'dart:convert';

List<Getenachtoakenresponse> getenachtoakenresponseFromJson(String str) =>
    List<Getenachtoakenresponse>.from(
        json.decode(str).map((x) => Getenachtoakenresponse.fromJson(x)));

String getenachtoakenresponseToJson(List<Getenachtoakenresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getenachtoakenresponse {
  String? status;
  String? message;
  String? token;
  String? customerMobile;
  String? customerEmail;
  String? emiStartDate;
  String? emiEndDate;
  String? emiAmount;
  String? merchantId;
  String? amountType;
  String? frequency;
  String? transactionId;

  Getenachtoakenresponse({
    this.status,
    this.message,
    this.token,
    this.customerMobile,
    this.customerEmail,
    this.emiStartDate,
    this.emiEndDate,
    this.emiAmount,
    this.merchantId,
    this.amountType,
    this.frequency,
    this.transactionId,
  });

  factory Getenachtoakenresponse.fromJson(Map<String, dynamic> json) =>
      Getenachtoakenresponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        customerMobile: json["customer_mobile"],
        customerEmail: json["customer_email"],
        emiStartDate: json["emi_start_date"],
        emiEndDate: json["emi_end_date"],
        emiAmount: json["emi_amount"],
        merchantId: json["merchantId"],
        amountType: json["amountType"],
        frequency: json["frequency"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "customer_mobile": customerMobile,
        "customer_email": customerEmail,
        "emi_start_date": emiStartDate,
        "emi_end_date": emiEndDate,
        "emi_amount": emiAmount,
        "merchantId": merchantId,
        "amountType": amountType,
        "frequency": frequency,
        "transaction_id": transactionId,
      };
}
