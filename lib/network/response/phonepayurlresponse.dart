// To parse this JSON data, do
//
//     final phonepayurlresponse = phonepayurlresponseFromJson(jsonString);

import 'dart:convert';

List<Phonepayurlresponse> phonepayurlresponseFromJson(String str) =>
    List<Phonepayurlresponse>.from(
        json.decode(str).map((x) => Phonepayurlresponse.fromJson(x)));

String phonepayurlresponseToJson(List<Phonepayurlresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Phonepayurlresponse {
  String? status;
  String? message;
  String? url;
  List<PhonepayurlDatum>? data;

  Phonepayurlresponse({
    this.status,
    this.message,
    this.url,
    this.data,
  });

  factory Phonepayurlresponse.fromJson(Map<String, dynamic> json) =>
      Phonepayurlresponse(
        status: json["status"],
        message: json["message"],
        url: json["url"],
        data: json["data"] == null
            ? []
            : List<PhonepayurlDatum>.from(
                json["data"]!.map((x) => PhonepayurlDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "url": url,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PhonepayurlDatum {
  String? merchantId;
  String? merchantTransactionId;
  String? merchantUserId;
  int? amount;
  String? redirectUrl;
  String? redirectMode;
  String? callbackUrl;
  String? merchantOrderId;
  int? mobileNumber;
  String? message;
  String? email;
  String? shortName;
  PaymentInstrument? paymentInstrument;

  PhonepayurlDatum({
    this.merchantId,
    this.merchantTransactionId,
    this.merchantUserId,
    this.amount,
    this.redirectUrl,
    this.redirectMode,
    this.callbackUrl,
    this.merchantOrderId,
    this.mobileNumber,
    this.message,
    this.email,
    this.shortName,
    this.paymentInstrument,
  });

  factory PhonepayurlDatum.fromJson(Map<String, dynamic> json) =>
      PhonepayurlDatum(
        merchantId: json["merchantId"],
        merchantTransactionId: json["merchantTransactionId"],
        merchantUserId: json["merchantUserId"],
        amount: json["amount"],
        redirectUrl: json["redirectUrl"],
        redirectMode: json["redirectMode"],
        callbackUrl: json["callbackUrl"],
        merchantOrderId: json["merchantOrderId"],
        mobileNumber: json["mobileNumber"],
        message: json["message"],
        email: json["email"],
        shortName: json["shortName"],
        paymentInstrument: json["paymentInstrument"] == null
            ? null
            : PaymentInstrument.fromJson(json["paymentInstrument"]),
      );

  Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "merchantTransactionId": merchantTransactionId,
        "merchantUserId": merchantUserId,
        "amount": amount,
        "redirectUrl": redirectUrl,
        "redirectMode": redirectMode,
        "callbackUrl": callbackUrl,
        "merchantOrderId": merchantOrderId,
        "mobileNumber": mobileNumber,
        "message": message,
        "email": email,
        "shortName": shortName,
        "paymentInstrument": paymentInstrument?.toJson(),
      };
}

class PaymentInstrument {
  String? type;

  PaymentInstrument({
    this.type,
  });

  factory PaymentInstrument.fromJson(Map<String, dynamic> json) =>
      PaymentInstrument(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
