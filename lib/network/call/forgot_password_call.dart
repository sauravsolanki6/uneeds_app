// To parse this JSON data, do
//
//     final forgotpasswordcall = forgotpasswordcallFromJson(jsonString);

import 'dart:convert';

Forgotpasswordcall forgotpasswordcallFromJson(String str) =>
    Forgotpasswordcall.fromJson(json.decode(str));

String forgotpasswordcallToJson(Forgotpasswordcall data) =>
    json.encode(data.toJson());

class Forgotpasswordcall {
  String? mobile;

  Forgotpasswordcall({
    this.mobile,
  });

  factory Forgotpasswordcall.fromJson(Map<String, dynamic> json) =>
      Forgotpasswordcall(
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}
