// To parse this JSON data, do
//
//     final sendrequestcall = sendrequestcallFromJson(jsonString);

import 'dart:convert';

Sendrequestcall sendrequestcallFromJson(String str) =>
    Sendrequestcall.fromJson(json.decode(str));

String sendrequestcallToJson(Sendrequestcall data) =>
    json.encode(data.toJson());

class Sendrequestcall {
  String? id;
  String? withdrawRequest;

  Sendrequestcall({
    this.id,
    this.withdrawRequest,
  });

  factory Sendrequestcall.fromJson(Map<String, dynamic> json) =>
      Sendrequestcall(
        id: json["id"],
        withdrawRequest: json["withdraw_request"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "withdraw_request": withdrawRequest,
      };
}
