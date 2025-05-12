// To parse this JSON data, do
//
//     final repaymentschedulecall = repaymentschedulecallFromJson(jsonString);

import 'dart:convert';

Repaymentschedulecall repaymentschedulecallFromJson(String str) =>
    Repaymentschedulecall.fromJson(json.decode(str));

String repaymentschedulecallToJson(Repaymentschedulecall data) =>
    json.encode(data.toJson());

class Repaymentschedulecall {
  String? id;
  String? tblEmiInnvoiceId;

  Repaymentschedulecall({
    this.id,
    this.tblEmiInnvoiceId,
  });

  factory Repaymentschedulecall.fromJson(Map<String, dynamic> json) =>
      Repaymentschedulecall(
        id: json["id"],
        tblEmiInnvoiceId: json["tbl_emi_innvoice_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_emi_innvoice_id": tblEmiInnvoiceId,
      };
}
