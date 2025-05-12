// To parse this JSON data, do
//
//     final emiwalletpaymentresponse = emiwalletpaymentresponseFromJson(jsonString);

import 'dart:convert';

List<Emiwalletpaymentresponse> emiwalletpaymentresponseFromJson(String str) =>
    List<Emiwalletpaymentresponse>.from(
        json.decode(str).map((x) => Emiwalletpaymentresponse.fromJson(x)));

String emiwalletpaymentresponseToJson(List<Emiwalletpaymentresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emiwalletpaymentresponse {
  String? status;
  String? message;
  String? tei;
  String? epi;
  Data? data;

  Emiwalletpaymentresponse({
    this.status,
    this.message,
    this.tei,
    this.epi,
    this.data,
  });

  factory Emiwalletpaymentresponse.fromJson(Map<String, dynamic> json) =>
      Emiwalletpaymentresponse(
        status: json["status"],
        message: json["message"],
        tei: json["tei"],
        epi: json["epi"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "tei": tei,
        "epi": epi,
        "data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
