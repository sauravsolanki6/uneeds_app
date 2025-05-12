// To parse this JSON data, do
//
//     final walletamountesponse = walletamountesponseFromJson(jsonString);

import 'dart:convert';

List<Walletamountesponse> walletamountesponseFromJson(String str) =>
    List<Walletamountesponse>.from(
        json.decode(str).map((x) => Walletamountesponse.fromJson(x)));

String walletamountesponseToJson(List<Walletamountesponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Walletamountesponse {
  String? status;
  String? creditWalletAmount;
  dynamic debitWalletAmount;
  String? balanceWalletAmount;
  String? uneed_wallet_balance;
  Data? data;

  Walletamountesponse({
    this.status,
    this.creditWalletAmount,
    this.debitWalletAmount,
    this.balanceWalletAmount,
    this.uneed_wallet_balance,
    this.data,
  });

  factory Walletamountesponse.fromJson(Map<String, dynamic> json) =>
      Walletamountesponse(
        status: json["status"],
        creditWalletAmount: json["credit_wallet_amount"],
        debitWalletAmount: json["debit_wallet_amount"],
        balanceWalletAmount: json["balance_wallet_amount"].toString(),
        uneed_wallet_balance: json["uneed_wallet_balance"].toString(),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "credit_wallet_amount": creditWalletAmount,
        "debit_wallet_amount": debitWalletAmount,
        "balance_wallet_amount": balanceWalletAmount,
        "uneed_wallet_balance": uneed_wallet_balance,
        "data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
