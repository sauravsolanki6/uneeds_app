// To parse this JSON data, do
//
//     final getwayactiveresponse = getwayactiveresponseFromJson(jsonString);

import 'dart:convert';

List<Getwayactiveresponse> getwayactiveresponseFromJson(String str) =>
    List<Getwayactiveresponse>.from(
        json.decode(str).map((x) => Getwayactiveresponse.fromJson(x)));

String getwayactiveresponseToJson(List<Getwayactiveresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getwayactiveresponse {
  String? status;
  String? message;
  String? phonepay;
  String? ccavenue;
  String? wallet;

  Getwayactiveresponse({
    this.status,
    this.message,
    this.phonepay,
    this.ccavenue,
    this.wallet,
  });

  factory Getwayactiveresponse.fromJson(Map<String, dynamic> json) =>
      Getwayactiveresponse(
        status: json["status"],
        message: json["message"],
        phonepay: json["phonepay"],
        ccavenue: json["ccavenue"],
        wallet: json["wallet"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "phonepay": phonepay,
        "ccavenue": ccavenue,
        "wallet": wallet,
      };
}
