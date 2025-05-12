// To parse this JSON data, do
//
//     final enachresponsecall = enachresponsecallFromJson(jsonString);

import 'dart:convert';

Enachresponsecall enachresponsecallFromJson(String str) =>
    Enachresponsecall.fromJson(json.decode(str));

String enachresponsecallToJson(Enachresponsecall data) =>
    json.encode(data.toJson());

class Enachresponsecall {
  String? enachResponse;

  Enachresponsecall({
    this.enachResponse,
  });

  factory Enachresponsecall.fromJson(Map<String, dynamic> json) =>
      Enachresponsecall(
        enachResponse: json["enach_response"],
      );

  Map<String, dynamic> toJson() => {
        "enach_response": enachResponse,
      };
}
