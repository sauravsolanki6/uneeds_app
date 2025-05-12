// To parse this JSON data, do
//
//     final updatecustomeridcall = updatecustomeridcallFromJson(jsonString);

import 'dart:convert';

Updatecustomeridcall updatecustomeridcallFromJson(String str) =>
    Updatecustomeridcall.fromJson(json.decode(str));

String updatecustomeridcallToJson(Updatecustomeridcall data) =>
    json.encode(data.toJson());

class Updatecustomeridcall {
  String? id;
  String? tblAddToCartId;

  Updatecustomeridcall({
    this.id,
    this.tblAddToCartId,
  });

  factory Updatecustomeridcall.fromJson(Map<String, dynamic> json) =>
      Updatecustomeridcall(
        id: json["id"],
        tblAddToCartId: json["tbl_add_to_cart_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tbl_add_to_cart_id": tblAddToCartId,
      };
}
