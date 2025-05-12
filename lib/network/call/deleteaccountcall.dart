// To parse this JSON data, do
//
//     final deleteaccountcall = deleteaccountcallFromJson(jsonString);

import 'dart:convert';

Deleteaccountcall deleteaccountcallFromJson(String str) =>
    Deleteaccountcall.fromJson(json.decode(str));

String deleteaccountcallToJson(Deleteaccountcall data) =>
    json.encode(data.toJson());

class Deleteaccountcall {
  String? userId;

  Deleteaccountcall({
    this.userId,
  });

  factory Deleteaccountcall.fromJson(Map<String, dynamic> json) =>
      Deleteaccountcall(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };
}
