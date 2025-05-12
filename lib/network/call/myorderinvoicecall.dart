// To parse this JSON data, do
//
//     final myorderinvoicecall = myorderinvoicecallFromJson(jsonString);

import 'dart:convert';

Myorderinvoicecall myorderinvoicecallFromJson(String str) =>
    Myorderinvoicecall.fromJson(json.decode(str));

String myorderinvoicecallToJson(Myorderinvoicecall data) =>
    json.encode(data.toJson());

class Myorderinvoicecall {
  String? tblInvoiceId;

  Myorderinvoicecall({
    this.tblInvoiceId,
  });

  factory Myorderinvoicecall.fromJson(Map<String, dynamic> json) =>
      Myorderinvoicecall(
        tblInvoiceId: json["tbl_invoice_id"],
      );

  Map<String, dynamic> toJson() => {
        "tbl_invoice_id": tblInvoiceId,
      };
}
