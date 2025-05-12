// To parse this JSON data, do
//
//     final emireceiptcall = emireceiptcallFromJson(jsonString);

import 'dart:convert';

Emireceiptcall emireceiptcallFromJson(String str) =>
    Emireceiptcall.fromJson(json.decode(str));

String emireceiptcallToJson(Emireceiptcall data) => json.encode(data.toJson());

class Emireceiptcall {
  String? tblRepaymentId;

  Emireceiptcall({
    this.tblRepaymentId,
  });

  factory Emireceiptcall.fromJson(Map<String, dynamic> json) => Emireceiptcall(
        tblRepaymentId: json["tbl_repayment_id"],
      );

  Map<String, dynamic> toJson() => {
        "tbl_repayment_id": tblRepaymentId,
      };
}
