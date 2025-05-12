// To parse this JSON data, do
//
//     final placeorderemiresponse = placeorderemiresponseFromJson(jsonString);

import 'dart:convert';

List<Placeorderemiresponse> placeorderemiresponseFromJson(String str) =>
    List<Placeorderemiresponse>.from(
        json.decode(str).map((x) => Placeorderemiresponse.fromJson(x)));

String placeorderemiresponseToJson(List<Placeorderemiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Placeorderemiresponse {
  String? status;
  String? message;
  Data? data;

  Placeorderemiresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Placeorderemiresponse.fromJson(Map<String, dynamic> json) =>
      Placeorderemiresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? tblEmiInnvoiceId;
  String? payableAmount;

  Data({
    this.tblEmiInnvoiceId,
    this.payableAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tblEmiInnvoiceId: json["tbl_emi_innvoice_id"],
        payableAmount: json["payable_amount"],
      );

  Map<String, dynamic> toJson() => {
        "tbl_emi_innvoice_id": tblEmiInnvoiceId,
        "payable_amount": payableAmount,
      };
}
