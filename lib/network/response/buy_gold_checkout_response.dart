// To parse this JSON data, do
//
//     final buygoldcheckoutresponse = buygoldcheckoutresponseFromJson(jsonString);

import 'dart:convert';

List<Buygoldcheckoutresponse> buygoldcheckoutresponseFromJson(String str) =>
    List<Buygoldcheckoutresponse>.from(
        json.decode(str).map((x) => Buygoldcheckoutresponse.fromJson(x)));

String buygoldcheckoutresponseToJson(List<Buygoldcheckoutresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buygoldcheckoutresponse {
  String? status;
  String? message;
  int? tblAddToCartId;

  Buygoldcheckoutresponse({
    this.status,
    this.message,
    this.tblAddToCartId,
  });

  factory Buygoldcheckoutresponse.fromJson(Map<String, dynamic> json) =>
      Buygoldcheckoutresponse(
        status: json["status"],
        message: json["message"],
        tblAddToCartId: json["tbl_add_to_cart_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "tbl_add_to_cart_id": tblAddToCartId,
      };
}
