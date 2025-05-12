// To parse this JSON data, do
//
//     final uniquemobilecall = uniquemobilecallFromJson(jsonString);

import 'dart:convert';

Uniquemobilecall uniquemobilecallFromJson(String str) =>
    Uniquemobilecall.fromJson(json.decode(str));

String uniquemobilecallToJson(Uniquemobilecall data) =>
    json.encode(data.toJson());

class Uniquemobilecall {
  String? mobile;

  Uniquemobilecall({
    this.mobile,
  });

  factory Uniquemobilecall.fromJson(Map<String, dynamic> json) =>
      Uniquemobilecall(
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}
