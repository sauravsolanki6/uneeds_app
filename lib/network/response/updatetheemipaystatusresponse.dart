// To parse this JSON data, do
//
//     final updatetheemipaystatusresponse = updatetheemipaystatusresponseFromJson(jsonString);

import 'dart:convert';

List<Updatetheemipaystatusresponse> updatetheemipaystatusresponseFromJson(
        String str) =>
    List<Updatetheemipaystatusresponse>.from(
        json.decode(str).map((x) => Updatetheemipaystatusresponse.fromJson(x)));

String updatetheemipaystatusresponseToJson(
        List<Updatetheemipaystatusresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Updatetheemipaystatusresponse {
  String? status;
  String? message;
  Data? data;

  Updatetheemipaystatusresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Updatetheemipaystatusresponse.fromJson(Map<String, dynamic> json) =>
      Updatetheemipaystatusresponse(
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
  String? tblEmiInvoiceId;

  Data({
    this.tblEmiInvoiceId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tblEmiInvoiceId: json["tbl_emi_invoice_id"],
      );

  Map<String, dynamic> toJson() => {
        "tbl_emi_invoice_id": tblEmiInvoiceId,
      };
}
