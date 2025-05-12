// To parse this JSON data, do
//
//     final buygoldplaceordercall = buygoldplaceordercallFromJson(jsonString);

import 'dart:convert';

Buygoldplaceordercall buygoldplaceordercallFromJson(String str) =>
    Buygoldplaceordercall.fromJson(json.decode(str));

String buygoldplaceordercallToJson(Buygoldplaceordercall data) =>
    json.encode(data.toJson());

class Buygoldplaceordercall {
  String? productId;
  String? id;
  String? tblAddToCartId;
  String? addressId;

  Buygoldplaceordercall({
    this.productId,
    this.id,
    this.tblAddToCartId,
    this.addressId,
  });

  factory Buygoldplaceordercall.fromJson(Map<String, dynamic> json) =>
      Buygoldplaceordercall(
        productId: json["product_id"],
        id: json["id"],
        tblAddToCartId: json["tbl_add_to_cart_id"],
        addressId: json["address_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "id": id,
        "tbl_add_to_cart_id": tblAddToCartId,
        "address_id": addressId,
      };
}
