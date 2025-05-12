// To parse this JSON data, do
//
//     final changepasswordcall = changepasswordcallFromJson(jsonString);

import 'dart:convert';

Changepasswordcall changepasswordcallFromJson(String str) =>
    Changepasswordcall.fromJson(json.decode(str));

String changepasswordcallToJson(Changepasswordcall data) =>
    json.encode(data.toJson());

class Changepasswordcall {
  String? password;
  String? id;

  Changepasswordcall({
    this.password,
    this.id,
  });

  factory Changepasswordcall.fromJson(Map<String, dynamic> json) =>
      Changepasswordcall(
        password: json["password"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "id": id,
      };
}
