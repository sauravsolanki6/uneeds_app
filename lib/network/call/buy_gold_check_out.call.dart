// To parse this JSON data, do
//
//     final buygoldcheckoutcall = buygoldcheckoutcallFromJson(jsonString);

import 'dart:convert';

Buygoldcheckoutcall buygoldcheckoutcallFromJson(String str) =>
    Buygoldcheckoutcall.fromJson(json.decode(str));

String buygoldcheckoutcallToJson(Buygoldcheckoutcall data) =>
    json.encode(data.toJson());

class Buygoldcheckoutcall {
  String? productId;
  String? id;

  Buygoldcheckoutcall({
    this.productId,
    this.id,
  });

  factory Buygoldcheckoutcall.fromJson(Map<String, dynamic> json) =>
      Buygoldcheckoutcall(
        productId: json["product_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "id": id,
      };
}
