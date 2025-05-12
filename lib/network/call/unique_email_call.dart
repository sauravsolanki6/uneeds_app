// To parse this JSON data, do
//
//     final uniqueemailcall = uniqueemailcallFromJson(jsonString);

import 'dart:convert';

Uniqueemailcall uniqueemailcallFromJson(String str) =>
    Uniqueemailcall.fromJson(json.decode(str));

String uniqueemailcallToJson(Uniqueemailcall data) =>
    json.encode(data.toJson());

class Uniqueemailcall {
  String? email;

  Uniqueemailcall({
    this.email,
  });

  factory Uniqueemailcall.fromJson(Map<String, dynamic> json) =>
      Uniqueemailcall(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
