// To parse this JSON data, do
//
//     final logincall = logincallFromJson(jsonString);

import 'dart:convert';

Logincall logincallFromJson(String str) => Logincall.fromJson(json.decode(str));

String logincallToJson(Logincall data) => json.encode(data.toJson());

class Logincall {
  String? mobile;
  String? password;

  Logincall({
    this.mobile,
    this.password,
  });

  factory Logincall.fromJson(Map<String, dynamic> json) => Logincall(
        mobile: json["mobile"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "password": password,
      };
}
