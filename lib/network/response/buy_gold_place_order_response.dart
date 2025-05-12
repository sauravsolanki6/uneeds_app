// To parse this JSON data, do
//
//     final buygoldplaceorderresponse = buygoldplaceorderresponseFromJson(jsonString);

import 'dart:convert';

List<Buygoldplaceorderresponse> buygoldplaceorderresponseFromJson(String str) =>
    List<Buygoldplaceorderresponse>.from(
        json.decode(str).map((x) => Buygoldplaceorderresponse.fromJson(x)));

String buygoldplaceorderresponseToJson(List<Buygoldplaceorderresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buygoldplaceorderresponse {
  String? status;
  String? message;
  Data? data;

  Buygoldplaceorderresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Buygoldplaceorderresponse.fromJson(Map<String, dynamic> json) =>
      Buygoldplaceorderresponse(
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
  String? tblInvoiceId;
  String? amount;

  Data({
    this.tblInvoiceId,
    this.amount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tblInvoiceId: json["tbl_invoice_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "tbl_invoice_id": tblInvoiceId,
        "amount": amount,
      };
}
