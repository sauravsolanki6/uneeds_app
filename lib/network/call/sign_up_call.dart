// To parse this JSON data, do
//
//     final signupcall = signupcallFromJson(jsonString);

import 'dart:convert';

Signupcall signupcallFromJson(String str) =>
    Signupcall.fromJson(json.decode(str));

String signupcallToJson(Signupcall data) => json.encode(data.toJson());

class Signupcall {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? password;
  String? referralCode;
  String? accept;

  Signupcall({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.password,
    this.referralCode,
    this.accept,
  });

  factory Signupcall.fromJson(Map<String, dynamic> json) => Signupcall(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobile: json["mobile"],
        password: json["password"],
        referralCode: json["referral_code"],
        accept: json["accept"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile": mobile,
        "password": password,
        "referral_code": referralCode,
        "accept": accept,
      };
}
