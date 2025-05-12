// To parse this JSON data, do
//
//     final otpverifyresponse = otpverifyresponseFromJson(jsonString);

import 'dart:convert';

List<Otpverifyresponse> otpverifyresponseFromJson(String str) =>
    List<Otpverifyresponse>.from(
        json.decode(str).map((x) => Otpverifyresponse.fromJson(x)));

String otpverifyresponseToJson(List<Otpverifyresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Otpverifyresponse {
  String? status;
  String? message;

  Otpverifyresponse({
    this.status,
    this.message,
  });

  factory Otpverifyresponse.fromJson(Map<String, dynamic> json) =>
      Otpverifyresponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
