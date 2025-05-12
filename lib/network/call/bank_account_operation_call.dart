// To parse this JSON data, do
//
//     final bankaccountoperationcall = bankaccountoperationcallFromJson(jsonString);

import 'dart:convert';

Bankaccountoperationcall bankaccountoperationcallFromJson(String str) =>
    Bankaccountoperationcall.fromJson(json.decode(str));

String bankaccountoperationcallToJson(Bankaccountoperationcall data) =>
    json.encode(data.toJson());

class Bankaccountoperationcall {
  String? id;
  String? tblBankAccountId;

  Bankaccountoperationcall({
    this.id,
    this.tblBankAccountId,
  });

  factory Bankaccountoperationcall.fromJson(Map<String, dynamic> json) =>
      Bankaccountoperationcall(
        id: json["id"],
        tblBankAccountId: json["tbl_bank_account_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_bank_account_id": tblBankAccountId,
      };
}
